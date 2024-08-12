const pool = require('../config/database');

exports.getEquipments = async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM equipment');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching equipments:', error.stack);
    res.status(500).json({ error: error.message });
  }
};

exports.getAllEquipments = async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT te.*, e.name 
      FROM tower_equipment te JOIN equipment e ON te.equipment_id = e.equipment_id`
      );
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching towers:', error.stack);
    res.status(500).json({ error: error.message });
  }
};

exports.getTowerEquipments = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(
      `SELECT e.*
       FROM equipment e
       JOIN tower_equipment te ON e.equipment_id = te.equipment_id
       WHERE te.creation_id = $1`,
      [id]
    );
    res.json(result.rows);
    console.log('Tower equipment:', result.rows);
  } catch (error) {
    console.error('Error fetching tower equipment:', error.stack);
    res.status(500).json({ error: error.message });
  }
};
