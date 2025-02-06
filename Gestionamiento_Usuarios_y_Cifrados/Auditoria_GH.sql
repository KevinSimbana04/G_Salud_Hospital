/*Auditoria*/

CREATE TABLE auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario varchar(100) NOT NULL,   -- Identificador del usuario que realizó el cambio
    operacion ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,  -- Tipo de operación realizada
    tabla_afectada VARCHAR(100) NOT NULL,  -- Nombre de la tabla afectada
    registro_id INT NOT NULL,  -- ID del registro afectado
    cambios TEXT NOT NULL,  -- Detalles de los cambios
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Fecha y hora del cambio
);

DELIMITER $$
-- Trigger para UPDATE en `datospersonales`
CREATE TRIGGER auditoria_update_datospersonales
AFTER UPDATE ON datospersonales
FOR EACH ROW
BEGIN
    DECLARE cambios TEXT;
    SET cambios = CONCAT(
        'Registro actualizado. ID: ', OLD.id,
        ', Nombre cambiado de ', OLD.nombres_completos, ' a ', NEW.nombres_completos,
        ', Teléfono cambiado de ', OLD.telefono, ' a ', NEW.telefono,
        ', Correo electrónico cambiado de ', OLD.correo_electronico, ' a ', NEW.correo_electronico
    );
    INSERT INTO auditoria (usuario, operacion, tabla_afectada, registro_id, cambios)
    VALUES (SUBSTRING_INDEX(CURRENT_USER(), '@', 1), 'UPDATE', 'datospersonales', OLD.id, cambios);
END $$

-- Trigger para DELETE en `datospersonales`
CREATE TRIGGER auditoria_delete_datospersonales
AFTER DELETE ON datospersonales
FOR EACH ROW
BEGIN
    DECLARE cambios TEXT;
    SET cambios = CONCAT('Registro eliminado. ID: ', OLD.id, ', Nombre: ', OLD.nombres_completos, ', Teléfono: ', OLD.telefono, ',telefonos: ', OLD.correo_electronico);
    INSERT INTO auditoria (usuario, operacion, tabla_afectada, registro_id, cambios)
    VALUES (SUBSTRING_INDEX(CURRENT_USER(), '@', 1), 'DELETE', 'datospersonales', OLD.id, cambios);
END $$

DELIMITER ;

/*Pacientes*/
DELIMITER $$
-- Trigger para UPDATE en `datospersonales`
CREATE TRIGGER auditoria_update_pacientes
AFTER UPDATE ON pacientes
FOR EACH ROW
BEGIN
    DECLARE cambios TEXT;
    SET cambios = CONCAT(
        ', Alergias de ', OLD.alergias, ' a ', NEW.alergias,
        ', contacto_emergencia_telefono de ', OLD.contacto_emergencia_telefono, ' a ', NEW.contacto_emergencia_telefono,
        ', contacto_emergencia_nombre de ', OLD.contacto_emergencia_nombre, ' a ', NEW.contacto_emergencia_nombre
    );
    INSERT INTO auditoria (usuario, operacion, tabla_afectada, registro_id, cambios)
    VALUES (SUBSTRING_INDEX(CURRENT_USER(), '@', 1), 'UPDATE', 'datospersonales', OLD.id, cambios);
END $$
DELIMITER ;


DELIMITER $$
-- Trigger para DELETE en `pacientes`
CREATE TRIGGER auditoria_delete_pacientes
AFTER DELETE ON pacientes
FOR EACH ROW
BEGIN
    DECLARE cambios TEXT;
    SET cambios = CONCAT(
        'Alergias: ', OLD.alergias, 
        ', Teléfono de contacto: ', OLD.contacto_emergencia_telefono, 
        ', Nombre de contacto: ', OLD.contacto_emergencia_nombre
    );
    INSERT INTO auditoria (usuario, operacion, tabla_afectada, registro_id, cambios)
    VALUES (SUBSTRING_INDEX(CURRENT_USER(), '@', 1), 'DELETE', 'pacientes', OLD.id, cambios);
END $$
DELIMITER ;


 DELIMITER $$
-- Trigger para UPDATE en `medicos`
CREATE TRIGGER auditoria_update_medicos
AFTER UPDATE ON medicos
FOR EACH ROW
BEGIN
    DECLARE cambios TEXT;
    SET cambios = CONCAT(
        ', tipo_de_contrato de ', OLD.tipo_contrato, ' a ', NEW.tipo_contrato,
        ', horario_entrada', OLD.horario_entrada, ' a ', NEW.horario_entrada,
        ', horario_salida', OLD.hora_salida, ' a ', NEW.hora_salida
    );
    INSERT INTO auditoria (usuario, operacion, tabla_afectada, registro_id, cambios)
    VALUES (SUBSTRING_INDEX(CURRENT_USER(), '@', 1), 'UPDATE', 'medicos', OLD.id, cambios);
END $$
DELIMITER ;

 DELIMITER $$
-- Trigger para UPDATE en `medicos`
CREATE TRIGGER auditoria_update_citas
AFTER UPDATE ON citas
FOR EACH ROW
BEGIN
    DECLARE cambios TEXT;
    SET cambios = CONCAT(
        ', cambio  de fecha ', OLD.fecha, ' a ', NEW.fecha,
        ', hora de inicio ', OLD.hora_inicio, ' a ', NEW.hora_inicio,
        ', hora de salida ', OLD.hora_finalizacion, ' a ', NEW.hora_finalizacion,
        ', estado ', OLD.estado, ' a ', NEW.estado
    );
    INSERT INTO auditoria (usuario, operacion, tabla_afectada, registro_id, cambios)
    VALUES (SUBSTRING_INDEX(CURRENT_USER(), '@', 1), 'UPDATE', 'citas', OLD.id, cambios);
END $$
DELIMITER ;


 DELIMITER $$
-- Trigger para UPDATE en `oredenes_examenes`
CREATE TRIGGER auditoria_update_ordenesexamenes
AFTER UPDATE ON ordenesexamenes
FOR EACH ROW
BEGIN
    DECLARE cambios TEXT;
    SET cambios = CONCAT(
        'cambio de  estado', OLD.estado, ' a ', NEW.estado
    );
    INSERT INTO auditoria (usuario, operacion, tabla_afectada, registro_id, cambios)
    VALUES (SUBSTRING_INDEX(CURRENT_USER(), '@', 1), 'UPDATE', 'oredenes_examenes', OLD.id, cambios);
END $$
DELIMITER ;

 DELIMITER $$
-- Trigger para UPDATE en `oredenes_examenes`
CREATE TRIGGER auditoria_update_medicamentos
AFTER UPDATE ON medicamentos
FOR EACH ROW
BEGIN
    DECLARE cambios TEXT;
    SET cambios = CONCAT(
        'stock ', OLD.stock, ' a ', NEW.stock
    );
    INSERT INTO auditoria (usuario, operacion, tabla_afectada, registro_id, cambios)
    VALUES (SUBSTRING_INDEX(CURRENT_USER(), '@', 1), 'UPDATE', 'medicamentos', OLD.id, cambios);
END $$
DELIMITER ;


