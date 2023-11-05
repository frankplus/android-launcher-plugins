import QtQuick 2.12;

QtObject {
    id: volla_weather;

    property var metadata: {
        'name': 'Weather Forecast',
        'description': 'It will add feature to get Weather Forecast directly from Springboard',
        'version': 0.1,
        'minLauncherVersion': 2.3,
        'maxLauncherVersion': 100
    }

    function init (inputParameter) {
        // todo: Load city ressouces
    }

    function executeInput (inputString, inputObject, functionId) {
        if (functionId === 0) {
            var parameter = inputObject !== undefined ? "weater " + inputObject : "weater " + inputString;
            Qt.openUrlExternally("https://startpage.com/sp/search?query=" + parameter.encodeURI() + "&segment=startpage.volla")
        } else {
            console.warn(metadata.id + " | Unknown function " + functionId + " called")
        }
    }

    function processInput (inputString) {
        // Process the input string here
        // Validate input for city names fpr autocompretion suggestions
        // Return an object containing the autocompletion or methods/functions
        var suggestions = new Array
        if (inputString.length > 1 && inputString.length < 100) {
            suggestions = [{'label' : 'Weather', 'functionId': 0}];

            if ('Berlin'.startsWith(inputString)) {
                suggestions.push([{'label' : 'Berlin', 'object' : 'Berlin DE'}])
            }
        }
        return suggestions
    }
}
