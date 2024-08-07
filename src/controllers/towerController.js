const pool = require('../config/database');

exports.getTowerTypes = async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM tower_type');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching tower types:', error.stack);
    res.status(500).json({ error: error.message });
  }
};

exports.createTower = async (req, res) => {
  const { towerType, latitude, longitude, equipments } = req.body;

  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    const insertTowerQuery = 'INSERT INTO tower_created (latitude, longitude) VALUES ($1, $2) RETURNING tower_Id';
    const towerResult = await client.query(insertTowerQuery, [latitude, longitude]);
    const newTowerId = towerResult.rows[0].tower_Id;

    const insertEquipmentQuery = 'INSERT INTO tower_equipment (tower_Id, equipment_Id) VALUES ($1, $2)';
    for (const equipmentId of equipments) {
      await client.query(insertEquipmentQuery, [newTowerId, equipmentId]);
    }

    await client.query('COMMIT');
    res.status(201).json({ tower_Id: newTowerId });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error creating tower:', error.stack);
    res.status(500).json({ error: error.message });
  } finally {
    client.release();
  }
};
