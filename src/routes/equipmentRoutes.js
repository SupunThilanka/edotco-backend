const express = require('express');
const equipmentController = require('../controllers/equipmentController');
const router = express.Router();

router.get('/equipments', equipmentController.getEquipments);
router.get('/created_equipments', equipmentController.getAllEquipments);
router.get('/towers/:id/equipments', equipmentController.getTowerEquipments);

module.exports = router;
