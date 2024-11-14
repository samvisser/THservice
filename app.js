// app.js
var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

// import PostgreSQL client
const { Client } = require('pg');

//import for local testing
require('dotenv').config();

// import routes
var codesRouter = require('./routes/courseCodes');
var tutorsRouter = require('./routes/tutors');
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);

// Use custom routes
app.use('/coursecodes', codesRouter);
app.use('/tutors', tutorsRouter);

// Test route for DB connection and environment variables
app.get('/test-db-connection', async (req, res) => {
  const dbServer = process.env.DB_SERVER;
  const dbPort = process.env.DB_PORT;
  const dbUser = process.env.DB_USER;
  const dbPassword = process.env.DB_PASSWORD;
  const dbDatabase = process.env.DB_DATABASE;

  // Check if all required environment variables are available
  if (!dbServer || !dbPort || !dbUser || !dbPassword || !dbDatabase) {
    return res.status(500).json({ error: 'Missing one or more environment variables' });
  }

  // Create PostgreSQL client
  const client = new Client({
    user: dbUser,
    host: dbServer,
    database: dbDatabase,
    password: dbPassword,
    port: dbPort,
    ssl: { rejectUnauthorized: false }
  });

  try {
    await client.connect();
    res.json({ message: 'Successfully connected to the database!' });
  } catch (err) {
    console.error('Database connection error:', err.stack);
    res.status(500).json({ error: 'Failed to connect to the database', details: err.message });
  } finally {
    await client.end();
  }
});

// Middleware to handle courseCodes errors
app.use('/coursecodes', async (req, res, next) => {
  try {
    await codesRouter(req, res, next);
  } catch (err) {
    console.error('Error in /coursecodes route:', err.stack);
    res.status(500).json({ error: 'Failed to retrieve course codes', details: err.message });
  }
});

// Catch-all route for undefined endpoints
app.use((req, res) => {
  res.status(404).json({ error: `Cannot GET ${req.originalUrl}` });
});

// Error handler
app.use((err, req, res, next) => {
  console.error('Unhandled error:', err.stack);
  res.status(err.status || 500).json({ error: err.message });
});

// debugging
app.use((req, res, next) => {
  console.log(`Incoming request: ${req.method} ${req.url}`);
  next();
});

module.exports = app;