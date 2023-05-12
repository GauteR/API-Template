const express = require('express');
const router = express.Router();

/**
 * @swagger
 * /health:
 *   get:
 *     summary: Check the health of the API
 *     responses:
 *       200:
 *         description: OK
 */
router.get('/health', (req, res) => {
  res.status(200).send('API is up and running');
});

module.exports = router;
