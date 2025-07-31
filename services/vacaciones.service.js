const Trabajador = require('../models/trabajador.model');
const Politica = require('../models/politica.model');

function calcularAntiguedad(fechaIngreso) {
  const hoy = new Date();
  const ingreso = new Date(fechaIngreso);
  let anios = hoy.getFullYear() - ingreso.getFullYear();
  const m = hoy.getMonth() - ingreso.getMonth();
  if (m < 0 || (m === 0 && hoy.getDate() < ingreso.getDate())) {
    anios--;
  }
  return anios >= 0 ? anios : 0;
}

async function actualizarDiasDisponibles(id_trabajador) {
  return new Promise((resolve, reject) => {
    Trabajador.getById(id_trabajador, (err, trabajadores) => {
      if (err) return reject(err);
      if (!trabajadores.length) return reject(new Error('Trabajador no encontrado'));

      const trabajador = trabajadores[0];
      const anios = calcularAntiguedad(trabajador.fecha_ingreso);

      Politica.getPoliticaPorAntiguedad(anios, (err2, politicas) => {
        if (err2) return reject(err2);
        if (!politicas.length) return reject(new Error('No hay política para esta antigüedad'));

        const diasAsignados = politicas[0].dias_vacacion_anuales;

        Trabajador.updateDiasDisponibles(id_trabajador, diasAsignados, err3 => {
          if (err3) return reject(err3);
          resolve(diasAsignados);
        });
      });
    });
  });
}

module.exports = { actualizarDiasDisponibles };
