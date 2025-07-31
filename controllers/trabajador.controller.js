const Trabajador = require('../models/trabajador.model');
const { actualizarDiasDisponibles } = require('../services/vacaciones.service');

exports.getAll = (req, res) => {
  Trabajador.getAll((err, data) => {
    if (err) return res.status(500).json({ error: 'Error al obtener trabajadores' });
    res.json(data);
  });
};

exports.actualizarVacaciones = async (req, res) => {
  const { id } = req.params;
  try {
    const dias = await actualizarDiasDisponibles(id);
    res.json({ mensaje: 'Días disponibles actualizados', dias_disponibles: dias });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};
