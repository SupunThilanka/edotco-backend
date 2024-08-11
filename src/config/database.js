const { Pool } = require('pg');

const pool = new Pool({
  user: 'edotco', // replace with your PostgreSQL username
  host: 'localhost',
  database: 'edotco', // replace with your PostgreSQL database name
  password: '1234', // replace with your PostgreSQL password
  port: 5432, // default PostgreSQL port
});

pool.connect((err) => {
  if (err) {
    console.error('Error connecting to the database:', err);
  } else {
    console.log('Connected to the database!');
  }
});

module.exports = pool;
