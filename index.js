const express = require('express');
const app = express();
app.get('/health', (req, res) => res.json({ status: 'ok' }));

// Only start the server if this file is run directly (not required by tests)
if (require.main === module) {
  app.listen(3000, () => console.log('API running on port 3000'));
}

module.exports = app;