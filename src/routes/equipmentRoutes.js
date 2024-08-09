const express = require('express');
const { getEquipments,getAllEquipments } = require('../controllers/equipmentController');
const router = express.Router();

router.get('/equipments', getEquipments);
router.get('/created_equipments', getAllEquipments);

module.exports = router;
