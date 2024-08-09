// src/kafkaProducer.js
const { Kafka } = require('kafkajs');

const kafka = new Kafka({
  clientId: 'tower-management-backend',
  brokers: ['52.21.129.119:9092'],
  sasl: {
    mechanism: 'plain',
    username: 'admin',
    password: 'admin-secret'
  },
  ssl: false
});

const producer = kafka.producer();

const run = async () => {
  await producer.connect();
  console.log('Kafka Producer connected');
};

run().catch(console.error);

const sendMessage = async (message) => {
  try {
    await producer.send({
      topic: 'tower_creation',
      messages: [{ value: JSON.stringify(message) }],
    });
    console.log('Message sent successfully');
  } catch (err) {
    console.error('Error sending message', err);
  }
};

module.exports = { sendMessage };
