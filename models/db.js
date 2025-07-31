const mysql = require('mysql2');
const dotenv = require('dotenv');
dotenv.config();

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT || 3306,
});

db.connect(err => {
  if (err) {
    console.error('Error al conectar a MySQL:', err.message);
    process.exit(1);
  } else {
    console.log(`Conectado a MySQL en host ${db.config.host}, base de datos ${db.config.database}, usuario ${db.config.user}, puerto ${db.config.port}`);
  }
});

module.exports = db;
