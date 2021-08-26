const sql = require('mssql');
const logger  = require('./logger');
const  moment  = require('moment');

const config = {
    user: process.env.SQL_USER,
    password: process.env.SQL_PASSWORD,
    server: process.env.SQL_SERVER,
    database: process.env.SQL_DATABASE,
    "options": {
      "encrypt": false,
      "enableArithAbort": true
      }
 }

const intentos = process.env.INTENTOS || 10;

const conexion = async () => {
    try {
        return await sql.connect(config);
    } catch (err) {
        logger.error(err);
    }
}

//#region selects
const selectEquipoEmpresa= async (equipo) => {
    return await conexion().then(pool => {
        return pool.request()
        .input('equipo', sql.VarChar, equipo)
        .query('select  equipo, registrycode, sessionid  from equipoempresa where equipo = @equipo');

    }).catch(err => {
        logger.error(err);
    });
}

const selectUser = async (equipo, enviado, elimnaruser) => {
    return await conexion().then(pool => {
        return pool.request()
        .input('enviado', sql.Int, enviado)
        .input('equipo', sql.VarChar, equipo)
        .input('elimnaruser', sql.VarChar, elimnaruser)
        .execute('SP_SEL_USER');

    }).catch(err => {
        logger.error(err);
    });
}

const selectComandos = async (equipo) => {
    return await conexion().then(pool => {
        return pool.request()
        .input('enviado', sql.Int, 0)
        .input('equipo', sql.VarChar, equipo)
        .query('select * from comandos where enviado = @enviado and equipo = @equipo');

    }).catch(err => {
        logger.error(err);
    });;
}

const selectTemplates = async (equipo) => {
    return await conexion().then(pool => {
        return pool.request()
        .input('enviado', sql.Int, 0)
        .input('equipo', sql.VarChar, equipo)
        .execute('SP_SEL_BIODATA')

    }).catch(err => {
        logger.error(err);
    });
}


const selectTimeZone = async (equipo) => {
    return await conexion().then(pool => {
        return pool.request()
        .input('enviado', sql.Int, 0)
        .input('equipo', sql.VarChar, equipo)
        .execute('SP_SEL_TIMEZONE')

    }).catch(err => {
        logger.error(err);
    });
}

const selectUserAuthorize = async (equipo, enviado) => {
    return await conexion().then(pool => {
        return pool.request()
        .input('enviado', sql.Int, enviado)
        .input('equipo', sql.VarChar, equipo)
        .execute('SP_SEL_USERAUTHORIZE')

    }).catch(err => {
        logger.error(err);
    });
}





//#endregion selects

//#region inserts

const insertarequipoNoRegistrado = async (equipo) =>{
    return await conexion().then(pool => {
        return pool.request()
        .input('equipo', sql.VarChar, equipo)
        .execute('SP_INS_EQUIPONOINSCRITO')
    }).catch(err => {
        logger.error(err);
    });
}

const insertarUser = async (user, equipo)=> {
    return await conexion().then(pool => {
        return pool.request()
        .input('uid', sql.Int, user.uid)
        .input('cardno', sql.VarChar, user.cardno)
        .input('pin', sql.Int, user.pin)
        .input('password', sql.VarChar, user.password)
        .input('group', sql.Int, user.group)
        .input('starttime', sql.VarChar, user.starttime)
        .input('endtime', sql.VarChar, user.endtime)
        .input('name', sql.VarChar, user.name)
        .input('privilege', sql.Int, user.privilege)
        .input('disable', sql.Int, user.disable)
        .input('verify', sql.Int, user.verify)
        .input('equipo', sql.VarChar, equipo)
        .execute('SP_INS_USER');

    }).catch(err => {
        logger.error(err);
    });
}


const insertarCmd = async (cmd, equipo) => {
    let insert = await  conexion().then(pool => {
        return pool.request()
        .input('equipo', sql.VarChar, equipo)
        .input('fecha', sql.DateTime2, new Date())
        .input('cmd', sql.VarChar, cmd)
        .input('enviado', sql.Int, 0)
        .query('INSERT INTO Comandos (equipo, fecha, cmd, enviado) VALUES (@equipo, @fecha, @cmd, @enviado)');

    }).catch(err => {
        logger.error(err);
    });
    return insert;
}



const insertarBioData= async (biodata, equipo) => {
    return await conexion().then(pool => {
        return pool.request()
        .input('equipo', sql.VarChar, equipo)
        .input('pin', sql.Int, biodata.pin)
        .input('no', sql.Int, biodata.no)
        .input('index', sql.Int, biodata.index)
        .input('valid', sql.Int, biodata.valid)
        .input('duress', sql.Int, biodata.duress)
        .input('type', sql.Int, biodata.type)
        .input('majorver', sql.VarChar, biodata.majorver)
        .input('minorver', sql.VarChar, biodata.minorver)
        .input('format', sql.VarChar, biodata.format)
        .input('tmp', sql.VarChar, biodata.tmp)
        .execute('SP_INS_BIODATA');

    }).catch(err => {
        logger.error(err);
    });
}


const insertarBioPhoto = async (biophoto, equipo) => {
    return await conexion().then(pool => {
        return pool.request()
        .input('equipo', sql.VarChar, equipo)
        .input('pin', sql.Int, biophoto.pin)
        .input('no', sql.Int, biophoto.no)
        .input('index', sql.Int, biophoto.index)
        .input('filename', sql.VarChar, biophoto.filename)
        .input('type', sql.Int, biophoto.type)
        .input('size', sql.Int, biophoto.size)
        .input('content', sql.VarChar, biophoto.content)
        .execute('SP_INS_BIOPHOTO');

    }).catch(err => {
        logger.error(err);
    });
}



const insertarRtstate= async (rtstate, equipo) => {
    return  await conexion().then(pool => {
        return pool.request()
        .input('equipo', sql.VarChar, equipo)
        .input('time', sql.VarChar, rtstate.time)
        .input('sensor', sql.VarChar, rtstate.sensor)
        .input('relay', sql.VarChar, rtstate.relay)
        .input('alarm', sql.VarChar, rtstate.alarm)
        .input('door', sql.VarChar, rtstate.door)
        .execute('SP_INS_RTSTATE');

    }).catch(err => {
        logger.error(err);
    });
}


const insertarRtlog= async (rtstate, equipo) => {
    return  await conexion().then(pool => {
        return pool.request()
        .input('equipo', sql.VarChar, equipo)
        .input('time', sql.VarChar, rtstate.time)
        .input('pin', sql.VarChar, rtstate.pin)
        .input('cardno', sql.VarChar, rtstate.cardno)
        .input('eventaddr', sql.VarChar, rtstate.eventaddr)
        .input('event', sql.VarChar, rtstate.event)
        .input('inoutstatus', sql.VarChar, rtstate.inoutstatus)
        .input('verifytype', sql.VarChar, rtstate.verifytype)
        .input('index', sql.VarChar, rtstate.index)
        .input('linkid', sql.VarChar, rtstate.linkid)
        .input('maskflag', sql.VarChar, rtstate.maskflag)
        .input('temperature', sql.VarChar, rtstate.temperature)
        .input('sitecode', sql.VarChar, rtstate.sitecode)
        .execute('SP_INS_RTLOG');

    }).catch(err => {
        logger.error(err);
    });
}

//#endregion inserts

//#region update

const actualizarEquipoEmpresa = async (equipo, registrycode, sessionid) => {
    return await conexion().then(pool => {
        return pool.request()
        .input('equipo', sql.VarChar, equipo)
        .input('registrycode', sql.VarChar, registrycode)
        .input('sessionid', sql.VarChar, sessionid)
        .query('update equipoempresa set registrycode = @registrycode, sessionid = @sessionid where equipo = @equipo');

    }).catch(err => {
        logger.error(err);
    });
}


const actualizarInfoEquipoEmpresa = async (equipo, infoequipo) => {
    return await conexion().then(pool => {
        return pool.request()
        .input('equipo', sql.VarChar, equipo)
        .input('infoequipo', sql.VarChar, infoequipo)
        .query('update equipoempresa set infoequipo = @infoequipo where equipo = @equipo');

    }).catch(err => {
        logger.error(err);
    });
}
/*
const cambiarestadoenviado  = async (sn_zk, cmdid, enviado) => {
    return  await conexion().then(pool => {
        return pool.request()
        .input('enviado', sql.Int, enviado)
        .input('sn_zk', sql.VarChar, sn_zk)
        .input('usuarioID', sql.Int, cmdid)
        .query('update usuario set enviado = @enviado where usuarioID = @usuarioID and sn = @sn_zk');

    }).catch(err => {
        logger.error(err);
    });
}
*/

const actualizarUserauthorize = async (equipoUserauthorizeID) => {
    return  await conexion().then(pool => {
        return pool.request()
        .input('enviado', sql.Int, 1)
        .input('equipoUserauthorizeID', sql.VarChar, equipoUserauthorizeID)
        .execute('SP_UPD_EQUIPOUSERAUTHORIZE');
    }).catch(err => {
        logger.error(err);
    });
}

const actualizarTimeZone = async (equipotimezoneID) => {
    return  await conexion().then(pool => {
        return pool.request()
        .input('enviado', sql.Int, 1)
        .input('equipotimezoneID', sql.VarChar, equipotimezoneID)
        .query('update equipotimezone set enviado = @enviado where equipotimezoneID = @equipotimezoneID');

    }).catch(err => {
        logger.error(err);
    });
}

const cambiarEstadoComando = async (cmdid) => {
    return  await conexion().then(pool => {
        return pool.request()
        .input('enviado', sql.Int, 1)
        .input('cmdid', sql.VarChar, cmdid)
        .query('update comandos set enviado = @enviado where cmdid = @cmdid');

    }).catch(err => {
        logger.error(err);
    });
}

const actualizarErrorDespuesDeNIntentos= async (cmdid, error) => {

logger.info(`comandoID ${cmdid} error ${error}  ${intentos}`)
    return  await conexion().then(pool => {
        return pool.request()
        .input('intentos', sql.Int, intentos)
        .input('error', sql.Int, error)
        .input('cmdid', sql.Int, cmdid)
        .execute('SP_UPD_ERRORCOMANDOS');
    }).catch(err => {
        logger.error(err);
    });
}

const actualizarEquipoBioData = async (equipoBioDataID) => {
    return await  conexion().then(pool => {
        return pool.request()
        .input('equipoBioDataID', sql.Int, equipoBioDataID)
        .input('enviado', sql.Int, 1)
        .query('update equipoBioData set enviado = @enviado WHERE EquipoBioDataID = @equipoBioDataID');

    }).catch(err => {
        logger.error(err);
    });
}


const actualizarFechaConexionEquipoEmpresa = async (equipo) => {
    return await conexion().then(pool => {
        return pool.request()
        .input('equipo', sql.VarChar, equipo)         
        .execute('SP_UPD_EQUIPOEMPRESA');     
        
    }).catch(err => {
        logger.error(err);
    });
}

const actualizarUser = async (equipoUserID) => {
    return await  conexion().then(pool => {
        return pool.request()
        .input('enviado', sql.Int, 1)
        .input('equipoUserID', sql.Int, equipoUserID)
        .execute('SP_UPD_EQUIPOUSER');

    }).catch(err => {
        logger.error(err);
    })
}




//#endregion update

//#endregion delete

const elimnarComandos = async () =>{
    const days = parseInt(process.env.DAYS_CMD_OLD || 5);
    const fecha =  moment().subtract(days, 'days').format();
    return  await conexion().then(pool => {
        return pool.request()
        .input('fecha', sql.DateTime2, fecha)
        .query('delete from comandos where fecha < @fecha');

    }).catch(err => {
        logger.error(err);
    });
}

//

module.exports = {
    selectEquipoEmpresa,
    actualizarInfoEquipoEmpresa,
    actualizarFechaConexionEquipoEmpresa,
    selectUser,
    selectTemplates,
    selectTimeZone,
    selectUserAuthorize,
    selectComandos,
    insertarCmd,
    insertarBioPhoto,
    insertarRtstate,
    insertarRtlog,
    insertarUser,
    insertarBioData,
    insertarequipoNoRegistrado,
    actualizarEquipoEmpresa,
    actualizarEquipoBioData,
    actualizarTimeZone,
    actualizarUserauthorize,
    actualizarUser,
    actualizarErrorDespuesDeNIntentos,
    cambiarEstadoComando,
    elimnarComandos


}