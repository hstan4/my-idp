const express = require('express');
const app = express();
app.get('/health', (req, res) => res.json({ status: 'ok' }));
if (require.main === module) {
  app.listen(3000, '0.0.0.0', () => console.log('API running on port 3000'));
}
module.exports = app;l