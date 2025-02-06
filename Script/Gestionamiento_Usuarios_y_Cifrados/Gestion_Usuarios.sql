-- 1. Crear usuarios
CREATE USER 'admin_h'@'localhost' IDENTIFIED  WITH caching_sha2_password BY 'password_admin_h';
CREATE USER 'medico_usuario'@'localhost' IDENTIFIED  WITH caching_sha2_password BY 'password_medico';
CREATE USER 'enfermera_usuario'@'localhost' IDENTIFIED WITH	caching_sha2_password BY 'password_enfermera';
CREATE USER 'administrativo_usuario'@'localhost' IDENTIFIED  WITH caching_sha2_password BY 'password_administrativo';
CREATE USER 'farmaceutico_usuario'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'password_farmaceutico';
CREATE USER 'tecnico_laboratorio_usuario'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'password_tecnico_laboratorio';

-- 2. Asignar permisos a los usuarios
-- Permisos para el usuario  admin_h
GRANT ALL PRIVILEGES ON hospital_buen_dia.* TO 'admin_h'@'localhost' WITH GRANT OPTION;

-- Permisos para el usuario medicos
GRANT USAGE ON hospital_buen_dia.* TO 'medico_usuario'@'localhost';
GRANT SELECT, UPDATE ON hospital_buen_dia.pacientes TO 'medico_usuario'@'localhost';
GRANT SELECT ON hospital_buen_dia.citas TO 'medico_usuario'@'localhost';
GRANT SELECT, INSERT, UPDATE ON hospital_buen_dia.historialmedico TO 'medico_usuario'@'localhost';

-- Permisos para el usuario  enfermeras
GRANT USAGE ON hospital_buen_dia.* TO 'medico_usuario'@'localhost';
GRANT SELECT ON hospital_buen_dia.citas TO  'enfermera_usuario'@'localhost';
GRANT SELECT ON hospital_buen_dia.historialmedico TO  'enfermera_usuario'@'localhost';
GRANT SELECT ON hospital_buen_dia.pacientes TO  'enfermera_usuario'@'localhost';

-- Permisos para el usuario personal_administrativo
GRANT USAGE ON hospital_buen_dia.* TO 'administrativo_usuario'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_buen_dia.datospersonales TO 'administrativo_usuario'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_buen_dia.citas TO 'administrativo_usuario'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_buen_dia.medicos TO 'administrativo_usuario'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_buen_dia.pacientes TO 'administrativo_usuario'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_buen_dia.factura TO 'administrativo_usuario'@'localhost';

-- Permisos para el  farmaceuticos
GRANT USAGE ON hospital_buen_dia.* TO 'farmaceutico_usuario'@'localhost';
GRANT SELECT ON hospital_buen_dia.pacientes TO 'farmaceutico_usuario'@'localhost';
GRANT SELECT ON hospital_buen_dia.medicos TO 'farmaceutico_usuario'@'localhost';
GRANT SELECT ON hospital_buen_dia.citas TO 'farmaceutico_usuario'@'localhost';
GRANT SELECT, UPDATE ON hospital_buen_dia.medicamentos TO 'farmaceutico_usuario'@'localhost';

-- Permisos para el usuario tecnicos_laboratorio
GRANT USAGE ON hospital_buen_dia.* TO 'tecnico_laboratorio_usuario'@'localhost';
GRANT SELECT ON hospital_buen_dia.pacientes TO 'tecnico_laboratorio_usuario'@'localhost';
GRANT SELECT ON hospital_buen_dia.citas TO 'tecnico_laboratorio_usuario'@'localhost';
GRANT SELECT ON hospital_buen_dia.medicos TO 'tecnico_laboratorio_usuario'@'localhost';
GRANT SELECT, INSERT, UPDATE ON hospital_buen_dia.examenesmedicos TO 'tecnico_laboratorio_usuario'@'localhost';



/*Visualizacion_usuario*/
SELECT User, Host FROM mysql.user;

SELECT user, host, authentication_string, plugin FROM mysql.user;

SET GLOBAL log_bin_trust_function_creators = 1;
