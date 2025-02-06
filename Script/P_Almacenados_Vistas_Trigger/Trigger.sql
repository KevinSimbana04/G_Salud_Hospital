/* Triggers*/

/*datos_personales*/
 -- control datos duplicados
 DELIMITER //
 CREATE TRIGGER trg_no_datos_repetidos
BEFORE INSERT ON datospersonales
FOR EACH ROW
BEGIN
    DECLARE cuenta INT;

    -- Contar si ya existe una coincidencia exacta en número de identificación y nombre
    SELECT COUNT(*) INTO cuenta
    FROM datospersonales
    WHERE numero_indetificacion = NEW.numero_indetificacion
      AND nombres_completos = NEW.nombres_completos;

    -- Si ya existe, generar un error
    IF cuenta > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El registro con estos datos personales ya existe.';
    END IF;
END;
//
DELIMITER ;

/*
delimiter //
CREATE TRIGGER trg_validar_telefono 
BEFORE INSERT ON pacientes 
FOR EACH ROW 
BEGIN
    IF CHAR_LENGTH(NEW.telefono) <> 10 OR NOT NEW.telefono REGEXP '^[0-9]+$' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El número de teléfono debe tener 10 dígitos y contener solo números.';
    END IF;
END;
//
delimiter ;

*/

/*Preincripcion*/
-- Evitar medicamentos vencidos en prescripciones
DELIMITER //
CREATE TRIGGER trg_validar_vencimiento_medicamentos
BEFORE INSERT ON prescripcionesmedicas
FOR EACH ROW
BEGIN
    DECLARE fecha_venc DATE;

    SELECT fecha_vencimiento INTO fecha_venc
    FROM medicamentos
    WHERE id = NEW.medicamento_id;

    IF fecha_venc < CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El medicamento seleccionado está vencido.';
    END IF;
END;
//
DELIMITER  ;


/*Pacientes*/
-- Evitar eliminación de pacientes con citas pendientes
DELIMITER //
CREATE TRIGGER trg_evitar_eliminar_paciente
BEFORE DELETE ON pacientes
FOR EACH ROW
BEGIN
    DECLARE cuenta INT;

    SELECT COUNT(*) INTO cuenta 
    FROM citas 
    WHERE paciente_id = OLD.id AND estado = 'Pendiente';

    IF cuenta > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el paciente porque tiene citas pendientes.';
    END IF;
END;
//
DELIMITER ;

/*Citas*/
DELIMITER //
-- Validación de disponibilidad de médicos en citas
CREATE TRIGGER trg_validar_disponibilidad_medico 
BEFORE INSERT ON citas 
FOR EACH ROW 
BEGIN
    DECLARE cuenta INT;

    SELECT COUNT(*) INTO cuenta 
    FROM citas 
    WHERE medico_id = NEW.medico_id 
      AND fecha = NEW.fecha 
      AND ((NEW.hora_inicio BETWEEN hora_inicio AND hora_finalizacion) 
           OR (NEW.hora_finalizacion BETWEEN hora_inicio AND hora_finalizacion));

    IF cuenta > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El médico ya tiene una cita en este horario.';
    END IF;
END;
//
DELIMITER ;

-- Actualizar el estado de citas automáticamente
delimiter //
CREATE TRIGGER trg_actualizar_estado_cita
AFTER UPDATE ON citas
FOR EACH ROW
BEGIN
    IF NEW.hora_finalizacion < CURTIME() AND NEW.estado = 'Pendiente' THEN
        UPDATE citas SET estado = 'Completada' WHERE id = NEW.id;
    END IF;
END;
//
delimiter ;
