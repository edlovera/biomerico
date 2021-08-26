class biodata {

    pin = null;
    no = null;
    index = null;
    valid = null;
    duress = null;
    type = null;
    majorver = null;
    minorver = null;
    format = null;
    tmp = null;

    constructor(data) {
        Array.from(data).forEach(element => {
            if (element.startsWith('biodata pin='))
                this.pin = element.replace('biodata pin=', '');
            else if (element.startsWith('no='))
                this.no = element.replace('no=', '');
            else if (element.startsWith('index='))
                this.index = element.replace('index=', '');
            else if (element.startsWith('valid='))
                this.valid = element.replace('valid=', '');
            else if (element.startsWith('duress='))
                this.duress = element.replace('duress=', '');
            else if (element.startsWith('type='))
                this.type = element.replace('type=', '');
            else if (element.startsWith('majorver='))
                this.majorver = element.replace('majorver=', '');
            else if (element.startsWith('minorver='))
                this.minorver = element.replace('minorver=', '');
            else if (element.startsWith('format='))
                this.format = element.replace('format=', '');
            else if (element.startsWith('tmp='))
                this.tmp = element.replace('tmp=', '');

        })

    }


}

module.exports = biodata;