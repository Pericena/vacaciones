const db = require('./db');

const Solicitud = {
  getAll: cb => db.query('SELECT * FROM solicitud_vacaciones', cb),

  getById: (id, cb) => {
    db.query('SELECT * FROM solicitud_vacaciones WHERE id_solicitud = ?', [id], cb);
  },

  create: (data, cb) => {
    db.query('INSERT INTO solicitud_vacaciones SET ?', data, cb);
  },

  updateEstado: (id, estado, observaciones, id_admin, cb) => {
    db.query(
      'UPDATE solicitud_vacaciones SET estado = ?, observaciones = ?, id_administrador = ? WHERE id_solicitud = ?',
      [estado, observaciones, id_admin, id],
      cb
    );
  }
};

module.exports = Solicitud;
