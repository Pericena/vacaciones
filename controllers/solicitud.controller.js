const Solicitud = require('../models/solicitud.model');
const Trabajador = require('../models/trabajador.model');

exports.getAll = (req, res) => {
  const { id_trabajador } = req.query;

  let sql = 'SELECT * FROM solicitud_vacaciones';
  const params = [];

  if (id_trabajador) {
    sql += ' WHERE id_trabajador = ?';
    params.push(id_trabajador);
  }

  const db = require('../models/db');
  db.query(sql, params, (err, data) => {
    if (err) return res.status(500).json({ error: 'Error al obtener solicitudes' });
    res.json(data);
  });
};

exports.crearSolicitud = (req, res) => {
  const { id_trabajador, fecha_solicitud, fecha_inicio, fecha_fin, cantidad_dias, tipo_solicitud } = req.body;

  if (!id_trabajador || !fecha_solicitud || !fecha_inicio || !fecha_fin || !cantidad_dias || !tipo_solicitud) {
    return res.status(400).json({ error: 'Faltan datos obligatorios' });
  }

  const nuevaSolicitud = {
    id_trabajador,
    fecha_solicitud,
    fecha_inicio,
    fecha_fin,
    cantidad_dias,
    tipo_solicitud,
    estado: 'pendiente',
    id_administrador: null,
    observaciones: ''
  };

  Solicitud.create(nuevaSolicitud, (err, result) => {
    if (err) return res.status(500).json({ error: 'Error al crear solicitud' });
    res.status(201).json({ mensaje: 'Solicitud creada', id_solicitud: result.insertId });
  });
};

exports.actualizarEstadoSolicitud = (req, res) => {
  const { id } = req.params;
  const { estado, observaciones, id_administrador } = req.body;

  if (!['pendiente', 'aprobada', 'rechazada'].includes(estado)) {
    return res.status(400).json({ error: 'Estado inválido' });
  }

  Solicitud.updateEstado(id, estado, observaciones, id_administrador, err => {
    if (err) return res.status(500).json({ error: 'Error al actualizar estado' });

    if (estado === 'aprobada') {
      const db = require('../models/db');
      db.query('SELECT id_trabajador, cantidad_dias FROM solicitud_vacaciones WHERE id_solicitud = ?', [id], (err2, rows) => {
        if (err2) return res.status(500).json({ error: 'Error al obtener solicitud' });
        if (!rows.length) return res.status(404).json({ error: 'Solicitud no encontrada' });

        const { id_trabajador, cantidad_dias } = rows[0];
        Trabajador.getById(id_trabajador, (err3, trabajador) => {
          if (err3) return res.status(500).json({ error: 'Error al obtener trabajador' });
          if (!trabajador.length) return res.status(404).json({ error: 'Trabajador no encontrado' });

          const nuevoDias = trabajador[0].dias_disponibles - cantidad_dias;
          if (nuevoDias < 0) {
            return res.status(400).json({ error: 'No hay suficientes días disponibles' });
          }

          Trabajador.updateDiasDisponibles(id_trabajador, nuevoDias, err4 => {
            if (err4) return res.status(500).json({ error: 'Error al actualizar días disponibles' });
            res.json({ mensaje: 'Solicitud aprobada y días actualizados' });
          });
        });
      });
    } else {
      res.json({ mensaje: 'Estado de solicitud actualizado' });
    }
  });
};
