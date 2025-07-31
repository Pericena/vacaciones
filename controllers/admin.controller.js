const Admin = require('../models/admin.model');


exports.getAll = (req, res) => {
  Admin.getAll((err, data) => {
    if (err) {
      console.error('Error real al obtener administradores:', err);
      return res.status(500).json({ error: 'Error al obtener administradores' });
    }
    res.json(data);
  });
};


exports.create = (req, res) => {
  const { nombre_completo, email } = req.body;
  if (!nombre_completo || !email) {
    return res.status(400).json({ error: 'Faltan datos obligatorios' });
  }
  Admin.create({ nombre_completo, email }, (err, result) => {
    if (err) return res.status(500).json({ error: 'Error al crear administrador' });
    res.status(201).json({ mensaje: 'Administrador creado', id_administrador: result.insertId });
  });
};
