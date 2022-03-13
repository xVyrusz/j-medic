const bcrypt = require('bcryptjs');
const store = require('./doctors.store')
const boom = require("@hapi/boom");
const saltRounds = 10;
// AQUÍ TIENES QUE HACER LA LÓGICA DE NEGOCIOS :D

const doctorCreation = async (data) => {
    // validate if user exists
    // no se k

    const hashedPassword = await new Promise((resolve, reject) => {
        bcrypt.hash(data.password, saltRounds, (err, hash) => {
            if (err) reject('Error hashing password');
            resolve(hash);
        })
    })

    // Check if user exists
    const objUser = await store.getUser(data);
    const objCedula = await store.getCedula(data);
    const user = Object.values(JSON.parse(JSON.stringify(objUser)));
    const cedula = Object.values(JSON.parse(JSON.stringify(objCedula)));

    console.log(user);
    console.log(cedula);

    if (user.length >= 1) {
        throw boom.conflict('El usuario ya existe');
    } else {
        if (cedula.length >= 1) {
            throw boom.conflict('La Cedula ya existe');
        } else {
            data.password = hashedPassword;
            return await store.createDoctor(data);
        }
    }
}

// const loginDoctor = async (email, password) => {
//     // login <---- 

//     const user = await store.getUserByEmail(email)
//     if(!user) {
//         throw boom.badData('Invalid email or password')
//     }
//     const match = await bcrypt.compare(password, user.password)
//     if (!match) {
//         throw boom.badData('Invalid email or password')
//     }
//     return 'credenciales'

// }

module.exports = {
    doctorCreation,
    // loginDoctor
}