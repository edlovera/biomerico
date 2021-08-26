require('dotenv').config();
const http = require('http');
const HttpDispatcher = require('httpdispatcher');
const biophoto = require('./modelo/biophoto');
const biodata = require('./modelo/biodata');
const rtstate = require('./modelo/rtstate');
const rtlog = require('./modelo/rtlog');
const user = require('./modelo/user');
const logger = require('./lib/logger');
const comando = require('./crear_comandos');
const { cambiarEstadoComando, insertarBioPhoto, insertarRtstate, insertarRtlog, insertarUser,
        insertarBioData, selectEquipoEmpresa, actualizarEquipoEmpresa, actualizarInfoEquipoEmpresa,
        insertarequipoNoRegistrado, elimnarComandos, actualizarErrorDespuesDeNIntentos, actualizarFechaConexionEquipoEmpresa } = require('./lib/sqlserver');
const { sessionID, registryCode } = require('./lib/utils');

const dispatcher = new HttpDispatcher();
const PORT = process.env.PORT || 8081;



dispatcher.onGet("/iclock/cdata", async function (req, res) {


    let url_test = req.url;
    let params = new URLSearchParams(url_test);
    let sn = params.get("/iclock/cdata?SN");

    logger.info(`SN: ${sn} Inicio de registro`);

    var date = new Date();

    res.writeHead(200, { 'Content-Type': 'text/html' }, { 'server': 'node/express' }, { 'Date': date });


    let existeEquipo = await selectEquipoEmpresa(sn);

    if (existeEquipo && existeEquipo.recordset.length == 1) {
        const session = sessionID(sn);
        const code = registryCode(sn);

        actualizarEquipoEmpresa(sn, code, session).then(c => {

            let resp2 = 'registry=ok' + '\n' + 'RegistryCode=' + code + '\n' + 'ServerVersion=3.1.1' + '\n' + 'ServerName=ADMS' + '\n' +
               'PushProtVer=3.2.0' + '\n' + 'ErrorDelay=60' + '\n' + 'RequestDelay=30' + '\n' + 'DisableUserFunOn=1' + '\n' + 'TransTimes=00:00 14:30' + '\n' + 'TransInterval=2' + '\n' +
               'TransTables=User Transaction ' + '\n' + 'Realtime=1 SessionID=' + session + '\n' + 'TimeoutSec=10';

            res.end(resp2);
        });

    } else {
        await insertarequipoNoRegistrado(sn);
        logger.info(`SN: ${sn} Equipo no registrado`);
        res.end('Ok');
    }




});



dispatcher.onPost("/iclock/registry", async function (req, res) {
    res.writeHead(200, { 'Content-Type': 'text/html' }, { 'server': 'node/http' });
    let url_test = req.url;
    let params = new URLSearchParams(url_test);
    let sn = params.get("/iclock/registry?SN");
    let infoData = req.body;

    let existeEquipo = await selectEquipoEmpresa(sn);

    if (existeEquipo && existeEquipo.recordset.length == 1) {
        let registrycode = existeEquipo.recordset[0].registrycode;
        actualizarInfoEquipoEmpresa(sn, infoData);
        res.end("RegistryCode=" + registrycode);

        logger.info(`SN: ${sn} Registro completado`);
    }
})




dispatcher.onPost("/iclock/ping", async function (req, res) {
    res.writeHead(200, { 'Content-Type': 'text/html' }, { 'server': 'node/http' });
    res.end("Ok");
})



dispatcher.onPost("/iclock/push", async function (req, res) {
    res.writeHead(200, { 'Content-Type': 'text/html' }, { 'server': 'node/http' });

    let url_test = req.url;
    let params = new URLSearchParams(url_test);
    let sn = params.get("/iclock/push?SN");

    let existeEquipo = await selectEquipoEmpresa(sn);
    if (existeEquipo && existeEquipo.recordset.length == 1) { 
        let sessionid = existeEquipo.recordset[0].sessionid;

        let resp2 = 'ServerVersion=3.1.1' + '\n' + 'ServerName=ADMS' + '\n' + 'PushVersion=3.2.0' + '\n' + 'ErrorDelay=60' + '\n' +
            'RequestDelay=30' + '\n' + 'TransTimes=00:00 14:30' + '\n' + 'TransInterval=2' + '\n' + 'TransTables=User Transaction' + '\n' +
            'Realtime=1' + '\n' + 'SessionID=' + sessionid + '\n' + 'TimeoutSec=10' + '\n' + 'DisableUserFunOn=0' + '\n' + 'MultiBioDataSupport=1:1:1:1:1:1:1:1:1:1' + '\n' + 'MultiBioPhotoSupport=1:1:1:1:1:1:1:1:1:1';

        logger.info(`SN: ${sn} Enviando info al equipo`);
        res.end(resp2);
    }

})





dispatcher.onPost("/iclock/cdata", async function (req, res) {
    res.writeHead(200, { 'Content-Type': 'text/html' }, { 'server': 'node/http' });
    const url_test = req.url;

    const params = new URLSearchParams(url_test);
    const sn = params.get("/iclock/cdata?SN");
    const tablename = params.get("tablename");
    const table = params.get("table");


    logger.info(`SN: ${sn} /iclock/cdata`);

    let data = req.body;
    let eventos = data.split('\r\n');

    let promesas = [];
    let desconocido = false;
    eventos.forEach(element => {
        if (element) {
            let result;
            let campos = element.split('\t');
            if (table === 'rtstate') {
                const modelRtstate = new rtstate(campos)
                result = insertarRtstate(modelRtstate, sn);
                logger.info(`SN: ${sn} se recibe rtstate`);
            }
            else if (table === 'rtlog') {
                const modelrtlog = new rtlog(campos)
                result = insertarRtlog(modelrtlog, sn);
                logger.info(`SN: ${sn} se recibe rtlog`);
            }
            else if (tablename === 'biophoto') {
                const modelBiophoto = new biophoto(campos)
                result = insertarBioPhoto(modelBiophoto, sn);
                logger.info(`SN: ${sn} se recibe biophoto`);

            } else if (tablename === 'biodata') {
                const modelBioData = new biodata(campos)
                result = insertarBioData(modelBioData, sn);
                logger.info(`SN: ${sn} se recibe biodata`);

            } else if (tablename === 'user') {
                const modelUser = new user(campos)
                result = insertarUser(modelUser, sn);
                logger.info(`SN: ${sn} se recibe user`);
            } else {
                desconocido = true;
                logger.info(`SN: ${sn} se recibe valor desconocido`);
                logger.debug(`SN: ${sn} tablename: ${tablename}, table: ${table} campos: ${element}}`);
            }
            promesas.push(result);
        }

    });

    const promesa = await Promise.all(promesas);
    let count = promesa.filter(x => x);

    if (desconocido) {
        res.end('Ok:' + 1);
    }
    if(count.length > 0 && !desconocido) {
        res.end('Ok:' + count.length);
    }

});

dispatcher.onGet("/iclock/getrequest", async function (req, res) {

    res.writeHead(200, { 'Content-Type': 'text/html' }, { 'server': 'node/express' });
    let url_test = req.url;
    let params = new URLSearchParams(url_test);
    let sn = params.get("/iclock/getrequest?SN");

    logger.debug(`SN: ${sn} /iclock/getrequest`);

    await actualizarFechaConexionEquipoEmpresa(sn);

    /*****************************************************
        Este bloque crea los comandos en  la base de datos
    ******************************************************/
    await comando.crearTemplates(sn);       // Crea los templete de las huellas, palma y rostro
    await comando.crearTimeZone(sn);        // Crea los horarios
    await comando.crearUserAuthorize(sn);   // Asocia los horarios a los usuarios
    await comando.eliminarUser(sn);         // Elimina los usuarios
    await comando.crearUser(sn);            // Crea los usuarios

    const cmd = await comando.buscarComando(sn);



    if (cmd) {
        logger.info(`SN: ${sn} Comando enviado: ${cmd}`);
        res.end(cmd);
        return;
    }

    // ELimina los comandos que esten mas de determinados dias en la base de datos
    let a = await elimnarComandos();

    res.end('Ok');

});



//Coloque esto para verificar si entra en algún momento
dispatcher.onPost("/iclock/cade", async function (req, res) {
    res.writeHead(200, { 'Content-Type': 'text/html' }, { 'server': 'node/http' });
    console.log(req.url);
    console.log(req.body);
    res.end('Ok');
});

dispatcher.onPost("/iclock/querydata", async function (req, res) {
    res.writeHead(200, { 'Content-Type': 'text/html' }, { 'server': 'node/http' });
    res.end('Ok');

})

dispatcher.onPost("/iclock/devicecmd", async function (req, res) {

    let resp = req.body.split(/\r\n|\r|\n/);
    let url_test = req.url;
    let params = new URLSearchParams(url_test);
    let sn = params.get("/iclock/devicecmd?SN");


    resp.forEach(async element => {
        if (element) {
            const par = new URLSearchParams(element);
            let ret = Number(par.get('Return'));
            let id = par.get('ID')
            if (ret >= 0) {
                logger.info(`SN: ${sn} Comando recibido ID: ${id}`);
                await cambiarEstadoComando(Number(id));
            } else {
                logger.error(`SN: ${sn} Error recibido: ${ret}, ID Comando: ${id}`);
                await actualizarErrorDespuesDeNIntentos(Number(id), Number(ret));
            }
        }

    })


    var date = new Date();
    res.writeHead(200, { 'Content-Type': 'text/html' }, { 'server': 'node/express' }, { 'Date': date });
    res.end("OK:" + 1);

});

dispatcher.onGet("/", async (req, res) => {
        res.end("Estoy escuchando");
})



const handleRequest = (request, response) => {
    try {
        dispatcher.dispatch(request, response);
    } catch (err) {

        logger.error(`Error en index.js gestor de request ${err}` );
    }
}

const Server = http.createServer(handleRequest);
Server.listen(PORT, () => {
   logger.info(`Servidor escuchando por el puerto ${PORT}`);
});