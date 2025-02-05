/*Vistas*/
-- Información básica de pacientes
CREATE VIEW vista_pacientes AS
SELECT p.id AS paciente_id,dp.nombres_completos AS nombre_paciente,dp.numero_indetificacion AS identificacion,dp.telefono,dp.correo_electronico,p.grupo_sanguineo,p.alergias,
    p.enfermedades_preexistentes
FROM 
    pacientes p
JOIN datospersonales dp ON p.datos_personales_id = dp.id;

-- Historial médico por paciente
CREATE VIEW vista_historial_medico AS
SELECT h.paciente_id,dp.nombres_completos AS nombre_paciente,c.fecha AS fecha_cita,h.descripcion,h.diagnostico,h.tratamiento_recomendado,h.estado_general
FROM 
    historialmedico h
JOIN citas c ON h.cita_id = c.id
JOIN datospersonales dp ON h.paciente_id = dp.id;
    
    
-- Facturación detallada por cita
CREATE VIEW vista_facturacion_citas AS
SELECT f.id AS factura_id,c.id AS cita_id,dp.nombres_completos AS nombre_paciente,f.fecha_emision,f.subtotal,f.impuestos,f.total,f.total_examenes,f.total_medicamentos,
    f.estado_pago
FROM 
    facturas f
JOIN citas c ON f.cita_id = c.id
JOIN pacientes p ON c.paciente_id = p.id
JOIN datospersonales dp ON p.datos_personales_id = dp.id;

-- Citas médicas activas 
CREATE VIEW vista_citas_activas AS
SELECT c.id AS cita_id,dp_p.nombres_completos AS paciente,dp_m.nombres_completos AS medico,c.fecha,c.hora_inicio,c.hora_finalizacion,c.estado
FROM 
    citas c
JOIN pacientes p ON c.paciente_id = p.id
JOIN datospersonales dp_p ON p.datos_personales_id = dp_p.id
JOIN medicos m ON c.medico_id = m.id
JOIN datospersonales dp_m ON m.datos_personales_id = dp_m.id
WHERE c.estado = 'Pendiente';

-- Medicamneto por stock
CREATE VIEW vista_medicamentos_stock AS
SELECT m.id AS medicamento_id,m.nombre,m.tipo_medicamento,m.presentacion,m.dosis,m.stock,m.fecha_vencimiento,p.nombre AS proveedor
FROM 
    medicamentos m
JOIN proveedores p ON m.proveedor_id = p.id
WHERE m.stock > 0;

-- Exámenes realizados por paciente
CREATE VIEW vista_examenes_paciente AS
SELECT o.cita_id,dp.nombres_completos AS nombre_paciente,e.nombre AS examen,o.resultados,o.fecha_realizacion,o.costo_examen
FROM 
    ordenesexamenes o
JOIN examenesmedicos e ON o.examen_id = e.id
JOIN citas c ON o.cita_id = c.id
JOIN pacientes p ON c.paciente_id = p.id
JOIN datospersonales dp ON p.datos_personales_id = dp.id
WHERE o.estado = 'Realizado';

-- Información del personal médico
CREATE VIEW vista_personal_medico AS
SELECT m.id AS medico_id,dp.nombres_completos AS nombre_medico,e.nombre AS especialidad,
m.experiencia_years,m.fecha_ingreso,m.tipo_contrato
FROM 
	medicos m
JOIN datospersonales dp ON m.datos_personales_id = dp.id
JOIN especialidades e ON m.especialidad_id = e.id;
