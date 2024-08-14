const pool = require('../config/database');
const { sendMessage } = require('../kafkaProducer');

exports.SendAllToKafka = async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT tc.creation_id, tc.name as tower_name, tc.latitude, tc.longitude, tc.height, tc.status, 
             array_agg(e.name) as equipment_names
      FROM tower_created tc
      JOIN tower_type tt ON tc.tower_id = tt.tower_id
      LEFT JOIN tower_equipment te ON tc.creation_id = te.creation_id
      LEFT JOIN equipment e ON te.equipment_id = e.equipment_id
      GROUP BY tc.creation_id, tt.name
    `);

    const towers = result.rows;

    // Send the data to Kafka
    await sendMessage({ towers });
    console.log('All tower data sent to Kafka');

    res.status(200).json(towers);
  } catch (error) {
    console.error('Error fetching towers and sending to Kafka:', error.stack);
    res.status(500).json({ error: error.message });
  }
};
