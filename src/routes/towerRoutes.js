const express = require('express');
const { getTowerTypes, createTower } = require('../controllers/towerController');
const router = express.Router();

router.get('/tower-types', getTowerTypes);
router.post('/towers', createTower);

module.exports = router;
