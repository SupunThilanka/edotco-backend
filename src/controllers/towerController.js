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

// exports.getAllTowers = async (req, res) => {
//   try {
//     const result = await pool.query('SELECT * FROM tower_created');
//     res.json(result.rows);
//   } catch (error) {
//     console.error('Error fetching towers:', error.stack);
//     res.status(500).json({ error: error.message });
//   }
// };

exports.getAllTowers = async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT tc.*, tt.name as tower_name
       FROM tower_created tc
       JOIN tower_type tt ON tc.tower_id = tt.tower_id
`
    );
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching towers:', error.stack);
    res.status(500).json({ error: error.message });
  }
};

// Get a single tower by ID
exports.getTowerById = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(
      `SELECT tc.*, tt.name as tower_name, tt.image_location as tower_image
       FROM tower_created tc
       JOIN tower_type tt ON tc.tower_id = tt.tower_id
       WHERE tc.creation_id = $1`,
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Tower not found' });
    }

    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error fetching tower:', error.stack);
    res.status(500).json({ error: error.message });
  }
};


exports.createTower = async (req, res) => {
  const { towerType, name, latitude, longitude, equipment_Ids, equipment_names, height } = req.body;
  const status = 'pending';
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    const insertTowerQuery = 'INSERT INTO tower_created (longitude, latitude, tower_id, height) VALUES ($1, $2, $3, $4) RETURNING creation_id';
    const towerResult = await client.query(insertTowerQuery, [longitude, latitude, towerType, height]);

    const newCreationId = towerResult.rows[0].creation_id;
    console.log('New tower created with ID:', newCreationId);

    // Replace spaces in towerType with underscores
    const formattedName = name.replace(/ /g, '_');

    // Create the name by concatenating formatted tower type and creation id
    const createdName = `${formattedName}_${newCreationId}`;

    // Insert the name into the tower_created table
    const updateTowerNameQuery = 'UPDATE tower_created SET name = $1 WHERE creation_id = $2';
    await client.query(updateTowerNameQuery, [createdName, newCreationId]);

    const insertEquipmentQuery = 'INSERT INTO tower_equipment (creation_id, equipment_id) VALUES ($1, $2)';
    for (const equipmentId of equipment_Ids) {
      await client.query(insertEquipmentQuery, [newCreationId, equipmentId]);
    }

    await client.query('COMMIT');
    
    //Kafka message
    const towerData = {
      creationId: newCreationId,
      tower_name: createdName,
      latitude,
      longitude,
      height,
      status,
      equipment_names
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

// Update a tower
exports.updateTower = async (req, res) => {
  const { id } = req.params;
  const { towerType, name, longitude, latitude, height, equipment_Ids,equipment_names } = req.body;
  const status = 'updated';
  console.log('Update Parameters:', { id, towerType, longitude, latitude, height, equipment_Ids });

  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // Update the tower data
    const updateTowerQuery = `
      UPDATE tower_created 
      SET longitude = $1, latitude = $2, tower_id = $3, height = $4, status = 'updated'
      WHERE creation_id = $5 RETURNING creation_id
    `;
    const towerResult = await client.query(updateTowerQuery, [longitude, latitude, towerType, height, id]);

    const CreationId = towerResult.rows[0].creation_id;
    console.log('New tower created with ID:', CreationId);

    // Replace spaces in towerType with underscores
    const formattedName = name.replace(/ /g, '_');

    // Create the name by concatenating formatted tower type and creation id
    const Createdname = `${formattedName}_${CreationId}`;

    // Insert the name into the tower_created table
    const updateTowerNameQuery = 'UPDATE tower_created SET name = $1 WHERE creation_id = $2';
    await client.query(updateTowerNameQuery, [Createdname, CreationId]);
  

    console.log('Tower updated:', { id, longitude, latitude, towerType, height });

    const deleteEquipmentQuery = 'DELETE FROM tower_equipment WHERE creation_id = $1';
    await client.query(deleteEquipmentQuery, [id]);

    const insertEquipmentQuery = 'INSERT INTO tower_equipment (creation_id, equipment_id) VALUES ($1, $2)';
    for (const equipmentId of equipment_Ids) {
      await client.query(insertEquipmentQuery, [id, equipmentId]);
    }

    console.log('Equipment updated for tower:', { id, equipment_Ids });

    await client.query('COMMIT');

    //Kafka message
    const towerData = {
      CreationId,
      tower_name: Createdname,
      latitude,
      longitude,
      height,
      status,
      equipment_names
    };
    await sendMessage(towerData);
    console.log('Tower updated data sent to Kafka');

    res.json({ message: 'Tower updated successfully' });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error updating tower:', error.stack);
    res.status(500).json({ error: error.message });
  } finally {
    client.release();
  }
};

// Delete a tower
exports.deleteTower = async (req, res) => {
  const { id } = req.params;

  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    const deleteEquipmentQuery = 'DELETE FROM tower_equipment WHERE creation_id = $1';
    await client.query(deleteEquipmentQuery, [id]);

    const deleteTowerQuery = 'DELETE FROM tower_created WHERE creation_id = $1';
    await client.query(deleteTowerQuery, [id]);

    await client.query('COMMIT');
    res.json({ message: 'Tower deleted successfully' });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error deleting tower:', error.stack);
    res.status(500).json({ error: error.message });
  } finally {
    client.release();
  }
};
