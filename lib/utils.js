const { actualizarEquipoBioData } = require("./sqlserver");

const horasAEnteros = (element) => {
    const horas = element.split('-');
    const horaInicio = horas[0];
    const horaFin = horas[1];

    let hora1 = horaInicio.replace(':', '');
    let hora2 = horaFin.replace(':', '');

    hora1 = parseInt(hora1);
    hora2 = parseInt(hora2);

    return {hora1, hora2};

}

const elementLeftShift = (element) => {
    
    if(!element) return 0;

    const {hora1, hora2} = horasAEnteros(element);
    
    return (hora1 << 16) + hora2;

}

const dateAAAAMMDD =  (fecha) => {
    if(!fecha){
        return 0;
    }
    const date = new Date(fecha);
    let anio = date.getFullYear().toString();
    let mes = (date.getMonth() + 1).toString();
    let day = date.getUTCDay().toString();
    
    mes = mes.length = 1 ? '0'+mes : mes;
    day = day.length = 1 ? '0'+day : day;
    fechaFormato = anio + mes + day;
    return fechaFormato;
}

const guidAleatorio = (palabra) =>{
    let time = new Date().getTime().toString(); 
    const SEPARADOR = 'PALABRASEPARADOR';   
    let str = palabra + SEPARADOR + time;
    let buff = new Buffer.from(str).toString('base64');
    return buff;
}

const  registryCode = (equipo) => {
    let palabra = "REGISTRYCODE" + equipo;
    return guidAleatorio(palabra);
}

const sessionID = (equipo) => {
    let palabra = "SESSIONID" + equipo;
    return guidAleatorio(palabra);
}

module.exports  = {
    dateAAAAMMDD,
    elementLeftShift,
    sessionID,
    registryCode
}