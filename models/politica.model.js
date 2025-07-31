const db = require('./db');

const Politica = {
  getAll: cb => db.query('SELECT * FROM politica_vacacional ORDER BY anios_antiguedad_min', cb),

  getPoliticaPorAntiguedad: (anios, cb) => {
    const sql = `SELECT * FROM politica_vacacional WHERE ? BETWEEN anios_antiguedad_min AND anios_antiguedad_max LIMIT 1`;
    db.query(sql, [anios], cb);
  },

  create: (data, cb) => {
    db.query('INSERT INTO politica_vacacional SET ?', data, cb);
  }
};

module.exports = Politica;
