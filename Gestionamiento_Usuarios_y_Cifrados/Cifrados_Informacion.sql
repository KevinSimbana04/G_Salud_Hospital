/*cifrado de informacion*/
-- Definir la clave de cifrado para cada usuario
SET @clave_admin = 'claveAdminSegura!';
SET @clave_medico = 'claveMedico123!';
SET @clave_farmaceutico = 'claveFarmacia$!';
SET @clave_tecnico = 'claveTecnico#2023';

-- Aplicar el cifrado por usuario en la tabla `datospersonales`
UPDATE datospersonales 
SET nombre = AES_ENCRYPT(nombre, @clave_admin),
    telefono = AES_ENCRYPT(telefono, @clave_admin);

-- Cifrado de información confidencial en la tabla `pacientes`
UPDATE pacientes 
SET nombre = AES_ENCRYPT(nombre, @clave_medico),
    cedula = AES_ENCRYPT(cedula, @clave_admin);

-- Cifrado en la tabla `medicos`
UPDATE medicos 
SET nombre = AES_ENCRYPT(nombre, @clave_admin),
    especialidad = AES_ENCRYPT(especialidad, @clave_admin);

-- Cifrado en `historialmedico` solo para médicos
UPDATE historialmedico 
SET diagnostico = AES_ENCRYPT(diagnostico, @clave_medico);

-- Cifrado de detalles en `factura` solo accesible por personal administrativo
UPDATE factura 
SET detalles_pago = AES_ENCRYPT(detalles_pago, @clave_admin);

-- Cifrado en la tabla `medicamentos` accesible solo para farmacéuticos
UPDATE medicamentos 
SET nombre = AES_ENCRYPT(nombre, @clave_farmaceutico),
    dosis = AES_ENCRYPT(dosis, @clave_farmaceutico);

-- Cifrado en `examenesmedicos` solo accesible a técnicos de laboratorio
UPDATE examenesmedicos 
SET resultado = AES_ENCRYPT(resultado, @clave_tecnico);


-- Desencriptacion
-- Para administrativo_usuario
SELECT AES_DECRYPT(nombre, @clave_admin) AS nombre_descifrado 
FROM datospersonales;

-- Para medico_usuario
SELECT AES_DECRYPT(diagnostico, @clave_medico) AS diagnostico_descifrado 
FROM historialmedico;
