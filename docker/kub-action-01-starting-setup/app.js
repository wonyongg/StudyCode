const express = require('express');

const app = express();

app.get('/', (req, res) => {
  res.send(`
    <h1>hwangwonyong's kubernetes Test!</h1>
    <p>hehehe</p>
  `);
});

app.get('/error', (req, res) => {
  process.exit(1);
});

app.listen(8080);
