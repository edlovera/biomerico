class rtlog {

    time = null;
    pin = null;
    cardno = null;
    eventaddr = null;
    event = null;
    inoutstatus = null;
    verifytype = null;
    index = null;
    linkid = null;
    maskflag = null;
    temperature = null;
    sitecode = null;

    constructor(data) {
        Array.from(data).forEach(element => {
            if (element.startsWith('time='))
                this.time = element.replace('time=', '');
            else if (element.startsWith('pin='))
                this.pin = element.replace('pin=', '');
            else if (element.startsWith('cardno='))
                this.cardno = element.replace('cardno=', '');
            else if (element.startsWith('eventaddr='))
                this.eventaddr = element.replace('eventaddr=', '');
            else if (element.startsWith('event='))
                this.event = element.replace('event=', '');
            else if (element.startsWith('inoutstatus='))
                this.inoutstatus = element.replace('inoutstatus=', '');
            else if (element.startsWith('verifytype='))
                this.verifytype = element.replace('verifytype=', '');
            else if (element.startsWith('index='))
                this.index = element.replace('index=', '');
            else if (element.startsWith('linkid='))
                this.linkid = element.replace('linkid=', '');
            else if (element.startsWith('maskflag='))
                this.maskflag = element.replace('maskflag=', '');
            else if (element.startsWith('temperature='))
                this.temperature = element.replace('temperature=', '');
            else if (element.startsWith('sitecode='))
                this.sitecode = element.replace('sitecode=', '');

        })

    }
}

module.exports = rtlog;