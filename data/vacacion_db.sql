CREATE DATABASE IF NOT EXISTS vacaciones_db;
USE vacaciones_db;

CREATE TABLE trabajador (
  id_trabajador INT AUTO_INCREMENT PRIMARY KEY,
  ci VARCHAR(20) NOT NULL,
  nombre_completo VARCHAR(100) NOT NULL,
  fecha_ingreso DATE NOT NULL,
  area_trabajo VARCHAR(50),
  cargo VARCHAR(50),
  dias_disponibles DECIMAL(5,2) DEFAULT 0
);

CREATE TABLE administrador (
  id_administrador INT AUTO_INCREMENT PRIMARY KEY,
  nombre_completo VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE politica_vacacional (
  id_politica INT AUTO_INCREMENT PRIMARY KEY,
  anios_antiguedad_min INT NOT NULL,
  anios_antiguedad_max INT NOT NULL,
  dias_vacacion_anuales DECIMAL(5,2) NOT NULL
);

CREATE TABLE solicitud_vacaciones (
  id_solicitud INT AUTO_INCREMENT PRIMARY KEY,
  id_trabajador INT NOT NULL,
  fecha_solicitud DATE NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  cantidad_dias DECIMAL(5,2) NOT NULL,
  tipo_solicitud ENUM('día','hora') NOT NULL,
  estado ENUM('pendiente','aprobada','rechazada') DEFAULT 'pendiente',
  id_administrador INT DEFAULT NULL,
  observaciones TEXT,
  FOREIGN KEY (id_trabajador) REFERENCES trabajador(id_trabajador),
  FOREIGN KEY (id_administrador) REFERENCES administrador(id_administrador)
);
