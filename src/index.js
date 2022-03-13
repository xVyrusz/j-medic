const express = require('express');
const morgan = require('morgan');
const exphbs = require('express-handlebars');
const path = require('path');
const {
    logErrors,
    errorHandler,
    wrapErrors
} = require('./utils/middlewares/errorHandler');
const notFoundHandler = require('./utils/middlewares/notFound');


// Initializations
const app = express();

// Settings
app.set('port', process.env.PORT || 4000);
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', exphbs.engine({
    defaultLayout: 'main',
    layoutsDir: path.join(app.get('views'), 'layouts'),
    partialsDir: path.join(app.get('views'), 'partials'),
    extname: '.hbs',
    helpers: require('./lib/handlebars')
}));
app.set('view engine', '.hbs');

// Middleware
app.use(morgan('dev'));
app.use(express.urlencoded({
    extended: false
}));
app.use(express.json());

// Global Variables
app.use((req, res, next) => {
    next();
});

// Routes
app.use(require('./routes'));
app.use(require('./routes/authentication'));
app.use('/doctors', require('./routes/doctors'));

// Public
app.use(express.static(path.join(__dirname, 'public')));

// Not found
app.use(notFoundHandler);

//Error handlers
app.use(logErrors);
app.use(wrapErrors);
app.use(errorHandler);


// Starting the server
app.listen(app.get('port'), () => {
    console.log('Server on port', app.get('port'));
})