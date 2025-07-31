const db = require('./db');

const Admin = {
  getAll: cb => db.query('SELECT * FROM administrador', cb),
  create: (data, cb) => db.query('INSERT INTO administrador SET ?', data, cb),
};

module.exports = Admin;
