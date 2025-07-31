const express = require('express');
const router = express.Router();
const ctrl = require('../controllers/solicitud.controller');

router.get('/', ctrl.getAll);
router.post('/', ctrl.crearSolicitud);
router.put('/:id', ctrl.actualizarEstadoSolicitud);

module.exports = router;
