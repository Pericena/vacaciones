const db = require('./db');

const Trabajador = {
  getAll: cb => db.query('SELECT * FROM trabajador', cb),

  getById: (id, cb) => {
    db.query('SELECT * FROM trabajador WHERE id_trabajador = ?', [id], cb);
  },

  create: (data, cb) => {
    db.query('INSERT INTO trabajador SET ?', data, cb);
  },

  updateDiasDisponibles: (id, dias, cb) => {
    db.query('UPDATE trabajador SET dias_disponibles = ? WHERE id_trabajador = ?', [dias, id], cb);
  }
};

module.exports = Trabajador;
