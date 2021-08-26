const {transports, format, createLogger, treans } = require('winston');
const timezoned = () => {
    return new Date().toLocaleString('es-CL', {
        timeZone: 'America/Santiago'
    });
};
const logger = new createLogger({
    format:format.combine(format.timestamp({ format: timezoned, format: 'YYYY-MM-DD HH:mm:ss' }),format.prettyPrint()),

  transports: [
        new transports.Console({
            level: 'info',
            format:format.combine(format.timestamp({ format: timezoned ,format: 'YYYY-MM-DD HH:mm:ss'}),format.prettyPrint())
    
        })
  ]
});
module.exports = logger;