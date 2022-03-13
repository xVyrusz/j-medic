const express = require('express');
const router = express.Router();
const {
    createDoctorSchema,
    doctorIdSchema,
    loginSchema,
    updateDoctorSchema
} = require('../utils/validations/schemas/doctors.schema');
const validationHandler = require('../utils/middlewares/validationHandler');
const controller = require('./doctors.controller');

router.get('/add', (req, res) => {
    res.render('doctors/add');
})

router.post('/add', validationHandler(createDoctorSchema), async (req, res, next) => {
    const {
        nombre,
        apellidoP,
        apellidoM,
        usuario,
        password,
        cedula,
        telefono,
        turno
    } = req.body;
    const newDoctor = {
        nombre,
        apellidoP,
        apellidoM,
        usuario,
        password,
        cedula,
        telefono,
        turno
    };
    try {
        const doctorAdded = await controller.doctorCreation(newDoctor)
        res.render('doctors/added');
    } catch (error) {
        next(error);
        res.render('doctors/error');
    }
})

module.exports = router;