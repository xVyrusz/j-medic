const boom = require('@hapi/boom');

const errorStack = (err, stack) => {
    return {
        ...err,
        stack
    }
}

const logErrors = (err, req, res, next) => {
    console.log(err);
    next(err);
}

const wrapErrors = (err, req, res, next) => {
    if (!err.isBoom) {
        next(boom.badImplementation(err));
    }

    next(err);
}

const errorHandler = (err, req, res, next) => {
    const {
        output: {
            statusCode,
            payload
        }
    } = err;

    // res.status(statusCode);
    // res.json(errorStack(payload, err.stack));
}

module.exports = {
    logErrors,
    errorHandler,
    wrapErrors
}