
const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const routes = require('./routes');
const { errorHandler, notFound } = require('./middlewares/error.middleware');

const app = express();


app.use(cors());
app.use(morgan('dev')); 
app.use(express.json()); 


app.use('/api', routes);


app.use(notFound);


app.use(errorHandler);

module.exports = app;
