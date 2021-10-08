'use strict';

const express = require('express');

const PORT = process.env.APP_PORT;

// App
const app = express();
app.get('/', (req, res) => {
    res.send(`
        <h1>Hello world!</h1>
    `);
});

app.listen(PORT);
console.log(`Listening port ${PORT}`);