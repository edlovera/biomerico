class user {

    uid = null;
    cardno = null;
    pin = null;
    password = null;
    group = null;
    starttime = null;
    endtime = null;
    name = null;
    privilege = null;
    disable = null;
    verify = null;

    constructor(data) {
        Array.from(data).forEach(element => {
            if (element.startsWith('user uid='))
                this.uid = element.replace('user uid=', '');
            else if (element.startsWith('cardno='))
                this.cardno = element.replace('cardno=', '');
            else if (element.startsWith('pin='))
                this.pin = element.replace('pin=', '');
            else if (element.startsWith('password='))
                this.password = element.replace('password=', '');
            else if (element.startsWith('group='))
                this.group = element.replace('group=', '');
            else if (element.startsWith('starttime='))
                this.starttime = element.replace('starttime=', '');
            else if (element.startsWith('endtime='))
                this.endtime = element.replace('endtime=', '');
            else if (element.startsWith('name='))
                this.name = element.replace('name=', '');
            else if (element.startsWith('privilege='))
                this.privilege = element.replace('privilege=', '');
            else if (element.startsWith('disable='))
                this.disable = element.replace('disable=', '');
            else if (element.startsWith('verify='))
                this.verify = element.replace('verify=', '');
        })

    }
}

module.exports = user;