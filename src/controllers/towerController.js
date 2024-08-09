const pool = require('../config/database');
const { sendMessage } = require('../kafkaProducer');

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
  const { towerType, name, latitude, longitude, equipment_Ids, equipment_names, height } = req.body;

  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // Insert new tower into the tower_created table
    const insertTowerQuery = 'INSERT INTO tower_created (longitude, latitude, tower_id, height) VALUES ($1, $2, $3, $4) RETURNING creation_id';
    const towerResult = await client.query(insertTowerQuery, [longitude, latitude, towerType, height]);

    const newCreationId = towerResult.rows[0].creation_id;
    console.log('New tower created with ID:', newCreationId);

    // Insert equipment details into the tower_equipment table
    const insertEquipmentQuery = 'INSERT INTO tower_equipment (creation_id, equipment_id) VALUES ($1, $2)';
    for (const equipmentId of equipment_Ids) {
      await client.query(insertEquipmentQuery, [newCreationId, equipmentId]);
    }

    await client.query('COMMIT');
    
    // Kafka: Send tower creation data to Kafka topic
    const towerData = {
      name,
      latitude,
      longitude,
      equipment_names,
      creationId: newCreationId,
      height
    };
    await sendMessage(towerData);
    console.log('Tower creation data sent to Kafka');

    res.status(201).json({ creation_id: newCreationId });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error creating tower:', error.stack);
    res.status(500).json({ error: error.message });
  } finally {
    client.release();
  }
};
