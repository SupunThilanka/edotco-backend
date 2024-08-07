const express = require('express');
const { getEquipments } = require('../controllers/equipmentController');
const router = express.Router();

router.get('/equipments', getEquipments);

module.exports = router;
