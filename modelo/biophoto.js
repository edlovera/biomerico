class biophoto {

    pin = null;
    no = null;
    index = null;
    filename = null;
    type = null;
    size = null;
    content = null;

    constructor(data) {
        Array.from(data).forEach(element => {
            if (element.startsWith('biophoto pin='))
                this.pin = element.replace('biophoto pin=', '');
            else if (element.startsWith('no='))
                this.no = element.replace('no=', '');
            else if (element.startsWith('index='))
                this.index = element.replace('index=', '');
            else if (element.startsWith('filename='))
                this.filename = element.replace('filename=', '');
            else if (element.startsWith('type='))
                this.type = element.replace('type=', '');
            else if (element.startsWith('size='))
                this.size = element.replace('size=', '');
            else if (element.startsWith('content='))
                this.content = element.replace('content=', '');

        })

    }


}

module.exports = biophoto;