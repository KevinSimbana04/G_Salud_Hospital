-- Registrar nueva cita
DELIMITER //
CREATE PROCEDURE RegistrarCita(
    IN p_paciente_id INT,
    IN p_medico_id INT,
    IN p_fecha DATE,
    IN p_hora_inicio TIME,
    IN p_hora_finalizacion TIME,
    IN p_motivo TEXT,
    IN p_area_id INT
)
BEGIN
    INSERT INTO citas (paciente_id, medico_id, fecha, hora_inicio, hora_finalizacion, estado, motivo, area_id)
    VALUES (p_paciente_id, p_medico_id, p_fecha, p_hora_inicio, p_hora_finalizacion, 'Pendiente', p_motivo, p_area_id);
END;
//
DELIMITER ;


-- Actualizar estado de cita
DELIMITER //
CREATE PROCEDURE ActualizarEstadoCita(
    IN p_cita_id INT,
    IN p_nuevo_estado ENUM('Pendiente', 'Completada', 'Cancelada')
)
BEGIN
    UPDATE citas
    SET estado = p_nuevo_estado
    WHERE id = p_cita_id;
END;
//
DELIMITER ;

-- Registrar historial médico
DELIMITER //
CREATE PROCEDURE RegistrarHistorialMedico(
    IN p_cita_id INT,
    IN p_paciente_id INT,
    IN p_descripcion TEXT,
    IN p_diagnostico TEXT,
    IN p_tratamiento TEXT,
    IN p_medicamentos TEXT,
    IN p_estado_general ENUM('Bueno', 'Regular', 'Crítico')
)
BEGIN
    INSERT INTO historialmedico (cita_id, paciente_id, descripcion, diagnostico, tratamiento_recomendado, medicamentos_recetados, estado_general)
    VALUES (p_cita_id, p_paciente_id, p_descripcion, p_diagnostico, p_tratamiento, p_medicamentos, p_estado_general);
END;
//
DELIMITER ;


-- Consultar citas de un paciente
DELIMITER //
CREATE PROCEDURE ConsultarCitasPaciente(
    IN p_paciente_id INT
)
BEGIN
    SELECT * FROM citas WHERE paciente_id = p_paciente_id;
END;
//
DELIMITER ;

-- Registrar resultado de examen médico
DELIMITER //
CREATE PROCEDURE RegistrarResultadoExamen(
    IN p_examen_id INT,
    IN p_fecha_realizacion DATE,
    IN p_resultados TEXT
)
BEGIN
    UPDATE ordenesexamenes
    SET fecha_realizacion = p_fecha_realizacion, resultados = p_resultados, estado = 'Realizado'
    WHERE id = p_examen_id;
END;
//
DELIMITER ;


-- Registrar prescripción médica
DELIMITER //
CREATE PROCEDURE RegistrarPrescripcion(
    IN p_cita_id INT,
    IN p_medicamento_id INT,
    IN p_cantidad INT,
    IN p_costo_unitario DECIMAL(10,2),
    IN p_instrucciones TEXT
)
BEGIN
    INSERT INTO prescripcionesmedicas (cita_id, medicamento_id, cantidad, costo_unitario, instrucciones, estado)
    VALUES (p_cita_id, p_medicamento_id, p_cantidad, p_costo_unitario, p_instrucciones, 'Pendiente');
END;
//
DELIMITER ;

-- Consultar medicamentos disponibles
DELIMITER //
CREATE PROCEDURE ConsultarMedicamentosDisponibles()
BEGIN
    SELECT * FROM medicamentos WHERE stock > 0 AND fecha_vencimiento > CURRENT_DATE;
END;
//
DELIMITER ;


-- Registrar nuevo paciente
DELIMITER //
CREATE PROCEDURE RegistrarPaciente(
    IN p_datos_personales_id INT,
    IN p_grupo_sanguineo ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'),
    IN p_alergias TEXT,
    IN p_enfermedades_preexistentes TEXT,
    IN p_medicamentos_actuales TEXT,
    IN p_contacto_emergencia_nombre VARCHAR(100),
    IN p_contacto_emergencia_telefono VARCHAR(13)
)
BEGIN
    INSERT INTO pacientes (datos_personales_id, grupo_sanguineo, alergias, enfermedades_preexistentes, medicamentos_actuales, contacto_emergencia_nombre, contacto_emergencia_telefono)
    VALUES (p_datos_personales_id, p_grupo_sanguineo, p_alergias, p_enfermedades_preexistentes, p_medicamentos_actuales, p_contacto_emergencia_nombre, p_contacto_emergencia_telefono);
END;
//
DELIMITER 


-- Facturar cita médica
DELIMITER //
CREATE PROCEDURE FacturarCita(
    IN p_cita_id INT,
    IN p_subtotal DECIMAL(10,2),
    IN p_impuestos DECIMAL(10,2),
    IN p_total_examenes DECIMAL(10,2),
    IN p_total_medicamentos DECIMAL(10,2),
    IN p_metodo_pago ENUM('Efectivo', 'Tarjeta de Crédito', 'Transferencia Bancaria', 'Seguro Médico')
)
BEGIN
    DECLARE total DECIMAL(10,2);
    SET total = p_subtotal + p_impuestos + p_total_examenes + p_total_medicamentos;

    INSERT INTO facturas (cita_id, fecha_emision, subtotal, impuestos, total, total_examenes, total_medicamentos, estado_pago, metodo_pago)
    VALUES (p_cita_id, CURRENT_DATE, p_subtotal, p_impuestos, total, p_total_examenes, p_total_medicamentos, 'Pendiente', p_metodo_pago);
END;
//
DELIMITER ;


--  Actualizar stock de medicamentos
DELIMITER //
CREATE PROCEDURE ActualizarStockMedicamento(
    IN p_medicamento_id INT,
    IN p_nueva_cantidad INT
)
BEGIN
    UPDATE medicamentos
    SET stock = p_nueva_cantidad
    WHERE id = p_medicamento_id;
END;
//
DELIMITER ;
