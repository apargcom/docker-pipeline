'use strict';

const express = require('express');

const PORT = 3000;

// App
const app = express();
app.get('/', (req, res) => {
    res.send(`
        <h1>Hello world from ${process.env.HOSTNAME} container! Newly deployed using pipeline!!!</h1>
    `);
});

app.listen(PORT);
console.log(`Listening port ${PORT}`);