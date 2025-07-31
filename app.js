require('dotenv').config();

const express = require('express');
const app = express();

app.use(express.json());

app.use('/api/trabajadores', require('./routes/trabajador.routes'));
app.use('/api/admins', require('./routes/admin.routes'));
app.use('/api/solicitudes', require('./routes/solicitud.routes'));


app.use((req, res) => {
  res.status(404).json({ error: 'Ruta no encontrada' });
});

module.exports = app;
