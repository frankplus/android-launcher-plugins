import QtQuick 2.12;

QtObject {
    id: volla_weather;

    property var metadata: {
        'name': 'Weather Forecast',
        'description': 'It will add feature to get Weather Forecast directly from Springboard',
        'version': 0.1,
        'minLauncherVersion': 3,
        'maxLauncherVersion': 100
    }

    function init (inputParameter) {
        const stringProcessor = processInput (inputParameter);
        return stringProcessor;
    }

    function processInput (inputString) {
        // Process the input string here
        // Todo : Need to validate for city name and need to check if weather forecast app is installed
        // Return an object containing the autocompletion or methods/functions
        return [
            {
                "label" : "Weather",
                "funktion": function(inputString) {
                    console.debug("DO ANYTHING");
                }
            },
            {
                "label" : "Berlin",
                "object" : 1224455
            }
       ];
    }
}
