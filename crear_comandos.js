const logger = require('./lib/logger');
const { selectUser, insertarCmd, selectTemplates, actualizarEquipoBioData, selectComandos, selectTimeZone, actualizarTimeZone, selectUserAuthorize, actualizarUserauthorize, actualizarUser } = require('./lib/sqlserver');
const { dateAAAAMMDD, elementLeftShift } = require('./lib/utils');

const eliminarUser = async (sn) => {
    const enviado = 0;
    const eliminado = 1;
    return await selectUser(sn, enviado, eliminado).then(result => {

        if (result) {
            const res = result.recordset;

            res.forEach(async element => {

                let str1 = `C:[{cmdid}]:DATA DELETE userauthorize Pin=${element.Pin}`;
                let userauthorize = insertarCmd(str1, sn);
                let str2 = `C:[{cmdid}]:DATA DELETE templatev10 Pin=${element.Pin}`;
                let templatev10 = insertarCmd(str2, sn);
                let str3 = `C:[{cmdid}]:DATA DELETE user Pin=${element.Pin}`;
                let user = insertarCmd(str3, sn);
       

                let promesa = await Promise.all([userauthorize, templatev10, user]);

                if (promesa) {
                    await actualizarUser(element.EquipoUserID);
                }


            })
        }
    });
}

const crearUser = async (sn) => {
    const enviado = 0;
    const eliminado = 0;
    return await selectUser(sn, enviado, eliminado).then(result => {

        if (result) {
            const res = result.recordset;

            res.forEach(element => {
                let startTime = dateAAAAMMDD(element.StartTime);
                let endTime = dateAAAAMMDD(element.EndTime);
                let str = `C:[{cmdid}]:DATA UPDATE user CardNo=${element.CardNo}\tPin=${element.Pin}\tPassword=${element.Password}\tGroup=${element.Group}\tName=${element.Name}\tPrivilege=${element.Privilege}\tDisable=${element.Disable}\tStartTime=${element.StartTime}\tEndTime=${element.EndTime}\r\n`;
                insertarCmd(str, sn).then(async insertCmd => {
                    if (insertCmd.rowsAffected.length > 0)
                        await actualizarUser(element.EquipoUserID);
                });
            });
        }
    });
}



const buscarComando = async (sn) => {
    return await selectComandos(sn).then(result => {
        if (result) {
            const res = result.recordset;
            let cmds = [];

            res.forEach(cmd => {
                if (cmd)
                    cmds.push(cmd.Cmd.replace('[{cmdid}]', parseInt(cmd.CmdID)));
            });

            let str = cmds.join('\r\n');
            return str;

        }

    });
}

const crearTemplates = async (sn) => {
    return await selectTemplates(sn).then(async result => {
        if (result) {
            const res = result.recordset;

            res.forEach(element => {
                let str = `C:[{cmdid}]:DATA UPDATE biodata Pin=${element.Pin}\tNo=${element.No}\tIndex=${element.Index}\tValid=${element.Valid}\tDuress=${element.Duress}\tType=${element.Type}\tMajorVer=${element.Majorver}\tminorver=${element.Minorver}\tFormat=${element.Format}\tTmp=${element.Tmp}`;

                insertarCmd(str, sn).then(async insertCmd => {
                    if (insertCmd.rowsAffected.length > 0)
                        await actualizarEquipoBioData(element.EquipoBioDataID)
                });
            });
        }
    });
}

const crearTimeZone = async (sn) => {
    return await selectTimeZone(sn).then(async result => {
        if (result) {
            const res = result.recordset;

            res.forEach(element => {
                let str = `C:[{cmdid}]:DATA UPDATE timezone TimezoneId=${element.TimezoneID}\tSunTime1=${elementLeftShift(element.SunTime1)}\tSunTime2=${elementLeftShift(element.SunTime2)}\tSunTime3=${elementLeftShift(element.SunTime3)}\tMonTime1=${elementLeftShift(element.SunTime1)}\tMonTime2=${elementLeftShift(element.MonTime2)}\tMonTime3=${elementLeftShift(element.MonTime3)}\tTueTime1=${elementLeftShift(element.TueTime1)}\tTueTime2=${elementLeftShift(element.TueTime)}\tTueTime3=${elementLeftShift(element.TueTime3)}\tWedTime1=${elementLeftShift(element.WedTime1)}\tWedTime2=${elementLeftShift(element.WedTime2)}\tWedTime3=${elementLeftShift(element.WedTime3)}\tThuTime1=${elementLeftShift(element.ThuTime1)}\tThuTime2=${elementLeftShift(element.ThuTime2)}\tThuTime3=${elementLeftShift(element.ThuTime3)}\tFriTime1=${elementLeftShift(element.FriTime1)}\tFriTime2=${elementLeftShift(element.FriTime2)}\tFriTime3=${elementLeftShift(element.FriTime3)}\tSatTime1=${elementLeftShift(element.SatTime1)}\tSatTime2=${elementLeftShift(element.SatTime2)}\tSatTime3=${elementLeftShift(element.SatTime3)}\tHol1Time1=${elementLeftShift(element.Hol1Time1)}\tHol1Time2=${elementLeftShift(element.Hol1Time2)}\tHol1Time3=${elementLeftShift(element.Hol1Time3)}\tHol2Time1=${elementLeftShift(element.Hol2Time1)}\tHol2Time2=${elementLeftShift(element.Hol2Time2)}\tHol2Time3=${elementLeftShift(element.Hol2Time3)}\tHol3Time1=${elementLeftShift(element.Hol3Time1)}\tHol3Time2=${elementLeftShift(element.Hol3Time2)}\tHol3Time3=${elementLeftShift(element.Hol3Time3)}`;
                insertarCmd(str, sn).then(async insertCmd => {
                    if (insertCmd.rowsAffected.length > 0)
                        await actualizarTimeZone(element.EquipoTimezoneID)
                });
            });
        }
    });
}

const crearUserAuthorize = async (sn) => {
    return await selectUserAuthorize(sn, 0).then(async result => {
        if (result) {
            const res = result.recordset;

            res.forEach(element => {
                let str = `C:[{cmdid}]:DATA UPDATE userauthorize Pin=${element.Pin}\tAuthorizeTimezoneId=${element.AuthorizeTimezoneID}\tAuthorizeDoorId=${element.AuthorizeDoorID}\tDevID=${element.DevID}`;
                insertarCmd(str, sn).then(async insertCmd => {
                    if (insertCmd.rowsAffected.length > 0)
                        await actualizarUserauthorize(element.EquipoUserauthorizeID);
                });
            })
        }

    });
}


module.exports = {
    crearUser,
    crearTemplates,
    crearTimeZone,
    crearUserAuthorize,
    eliminarUser,
    buscarComando,

};