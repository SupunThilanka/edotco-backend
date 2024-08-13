const express = require('express');
const router = express.Router();
const kafkaController = require('../controllers/kafkaController');

// New route to get all kafkas and send to Kafka
router.get('/kafka/sendAll', kafkaController.SendAllToKafka);

module.exports = router;