const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors'); // Import the cors package
const towerRoutes = require('./routes/towerRoutes');
const equipmentRoutes = require('./routes/equipmentRoutes');

const app = express();

// Use the cors middleware
app.use(cors());

app.use(bodyParser.json());

app.use('/api', towerRoutes);
app.use('/api', equipmentRoutes);

const PORT = process.env.PORT || 8000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
