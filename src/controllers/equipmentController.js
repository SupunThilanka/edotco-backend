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
