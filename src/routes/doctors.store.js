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

const crateDoctor = async (data) => {
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

module.exports = {
    crateDoctor
}