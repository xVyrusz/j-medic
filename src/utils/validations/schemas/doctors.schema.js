const joi = require('joi');

const baseValidString = joi.string().min(3).max(100)

// nombre,
// apellidoP,
// apellidoM,
// usuario,
// contra,
// cedula,
// telefono,
// turno

const doctorIdSchema = joi.number();
const nombreSchema = baseValidString;
const apellidoSchema = baseValidString;
const usuarioSchema = baseValidString;
const passwordSchema = joi.string()
    .regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/)
    .message('Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character');
const cedulaSchema = joi.string().length(8).regex(/^[0-9]+$/).message('Cedula Invalida.')
const telefonoSchema = joi.string().min(8).max(20).regex(/^\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})$/).message('Numero de telefono invalido.')
const turnoSchema = joi.number().valid(1, 2, 3)

const createDoctorSchema = {
    nombre: nombreSchema.required(),
    apellidoP: apellidoSchema.required(),
    apellidoM: apellidoSchema.required(),
    usuario: usuarioSchema.required(),
    password: passwordSchema.required(),
    cedula: cedulaSchema.required(),
    telefono: telefonoSchema.required(),
    turno: turnoSchema.required(),
};

const updateDoctorSchema = {
    nombre: nombreSchema,
    apellidoP: apellidoSchema,
    apellidoM: apellidoSchema,
    usuario: usuarioSchema,
    password: passwordSchema,
    cedula: cedulaSchema,
    telefono: telefonoSchema,
    turno: turnoSchema,
}

const loginSchema = {
    usuario: usuarioSchema.required(),
    password: passwordSchema.required(),
}

module.exports = {
    createDoctorSchema,
    updateDoctorSchema,
    loginSchema,
    doctorIdSchema
}