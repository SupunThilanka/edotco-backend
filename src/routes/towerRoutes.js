const express = require('express');
const router = express.Router();
const towerController = require('../controllers/towerController');

router.get('/towers', towerController.getAllTowers); // Add this line
router.get('/tower-types', towerController.getTowerTypes);
router.post('/towers', towerController.createTower);

module.exports = router;
