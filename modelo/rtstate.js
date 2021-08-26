class rtstate {

    time = null;
    sensor = null;
    relay = null;
    alarm = null;
    door = null;

    constructor(data) {
        Array.from(data).forEach(element => {
            if (element.startsWith('time='))
                this.time = element.replace('time=', '');
            else if (element.startsWith('sensor='))
                this.sensor = element.replace('sensor=', '');
            else if (element.startsWith('relay='))
                this.relay = element.replace('relay=', '');
            else if (element.startsWith('alarm='))
                this.alarm = element.replace('alarm=', '');
            else if (element.startsWith('door='))
                this.door = element.replace('door=', '');

        })

    }
}

module.exports = rtstate;

