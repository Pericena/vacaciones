const express = require('express');
const router = express.Router();
const ctrl = require('../controllers/trabajador.controller');

router.get('/', ctrl.getAll);
router.post('/:id/actualizar-dias', ctrl.actualizarVacaciones);

module.exports = router;
