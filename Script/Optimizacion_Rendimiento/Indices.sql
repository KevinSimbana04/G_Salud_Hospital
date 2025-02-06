/* tabla_datos_personales */
CREATE INDEX idx_nombres_completos ON datospersonales(nombres_completos);
CREATE INDEX idx_correo_electronico ON datospersonales(correo_electronico);

/* tabla_medicos */
CREATE INDEX idx_especialidad_id ON medicos(especialidad_id);
CREATE INDEX idx_datos_personales_id_medicos ON medicos(datos_personales_id);

/* tabla_datos_personales */
CREATE INDEX idx_grupo_sanguineo ON pacientes(grupo_sanguineo);
CREATE INDEX idx_datos_personales_id_pacientes ON pacientes(datos_personales_id);

/* tabla_citas*/
CREATE INDEX idx_paciente_id ON citas(paciente_id);
CREATE INDEX idx_medico_id ON citas(medico_id);
CREATE INDEX idx_estado ON citas(estado);

/* ordenes de examenes*/
CREATE INDEX idx_cita_id_orden ON ordenesexamenes(cita_id);
CREATE INDEX idx_examen_id ON ordenesexamenes(examen_id);
CREATE INDEX idx_estado_orden ON ordenesexamenes(estado);

/*preinscripcion_medica*/
CREATE INDEX idx_cita_id_prescripcion ON prescripcionesMedicas(cita_id);
CREATE INDEX idx_medicamento_id ON prescripcionesMedicas(medicamento_id);
CREATE INDEX idx_estado_prescripcion ON prescripcionesMedicas(estado);

/*Tabla_factura*/
CREATE INDEX idx_fecha_emision_factura ON facturas(fecha_emision);
CREATE INDEX idx_estado_factura ON facturas(estado_pago);
CREATE INDEX idx_cita_id_factura ON facturas(cita_id);
