QtObject {
    id: volla.weather

    property var metadata: {
        'name': 'Weather Forecast',
        'description': 'It will add feature to get Weather Forecast directly from Springboard',
        'version': 0.1,
        'minLauncherVersion': 3,
        'maxLauncherVersion': 100
    }

    /*
    This is sample code need to execute at client side to start this script
    const item = init("testString");
    const methodNames = Object.keys(item);
    const methods = Object.values(item);
    console.log("returned item "+ methodNames + "  "+methods)
    if (typeof item[methodNames] === 'function') {
        console.log(`Executing ${methodNames}: ${item[methodNames]()}`)
    }
    */

    function init (inputParameter) {
        const stringProcessor = processInput (inputParameter)
        return stringProcessor
    }

    function processInput (inputString) {
        // Process the input string here
        // Todo : Need to validate for city anme and need to check if weather forecast app is installed
        // Return an object containing the methods/functions
        return {
            "Weather": function (inputString) {
                // todo: Need to launch weather forecast app.
            }
        }
    }
}
