const boom = require('@hapi/boom');

const errorStack = (err, stack) => {
    return {
        ...err,
        stack
    }
}

const logErrors = (err, req, res, next) => {
    if (config.dev) {
        console.log(err);
    } else {
        console.log(err.message);
    }
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

    res.status(statusCode);
    res.json(errorStack(payload, err.stack));

    // res.render('errors/errorView', {
    //     error: {
    //         payload,
    //         stack: err.stack,
    //         error: err
    //     }
    // })
}

module.exports = {
    logErrors,
    errorHandler,
    wrapErrors
}