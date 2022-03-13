const knex = require('knex')

const connection = knex({
    client: 'mysql',
    connection: {
        host: 'localhost',
        user: 'root',
        password: 'root',
        database: 'mydb'
    }
})

const createDoctor = async (data) => {
    return await connection('medicos').insert({
        nombreMedico: data.nombre,
        apellidoPMedico: data.apellidoP,
        apellidoMMedico: data.apellidoM,
        usuario: data.usuario,
        password: data.password,
        Cedula: data.cedula,
        Telefono: data.telefono,
        idTurnos_F: data.turno,
    });
}

const getUser = async (data) => {
    return await connection('medicos').select(
        'usuario'
    ).where({usuario: `${data.usuario}`});
}

const getCedula = async (data) => {
    return await connection('medicos').select(
        'cedula'
    ).where({cedula: `${data.cedula}`});
}

module.exports = {
    createDoctor,
    getUser,
    getCedula
}