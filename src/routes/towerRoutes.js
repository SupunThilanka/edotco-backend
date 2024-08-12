const express = require('express');
const router = express.Router();
const towerController = require('../controllers/towerController');

router.get('/towers', towerController.getAllTowers);
router.get('/tower-types', towerController.getTowerTypes);
router.post('/towers', towerController.createTower);

// Add the route to get a single tower by its ID
router.get('/towers/:id', towerController.getTowerById);

// Add the update route
router.put('/towers/:id', towerController.updateTower);

// Add the delete route
router.delete('/towers/:id', towerController.deleteTower);

module.exports = router;
