import QtQuick 2.12;

QtObject {

    property var metadata: {
        'id': 'volla_wikipedia',
        'name': 'Wikipedia',
        'description': 'It will add feature to open Wikipedia from Springboard',
        'version': 0.1,
        'minLauncherVersion': 2.3,
        'maxLauncherVersion': 100,
        'resources': [ ]
    }

    function init (inputParameter) {
        // todo: Load any resource if necessary
    }

    function executeInput (inputString, inputObject, functionId) {
        if (functionId === 0) {
            var parameter = inputObject !== undefined ? inputObject : inputString;
            var locale = Qt.locale().name;
            var url = "https://"+ locale.split('_')[0] + '.wikipedia.org/wiki/' + parameter;
            console.debug('Wiki Plugin | Will open ' + url);
            Qt.openUrlExternally(url);
        } else {
            console.warn(metadata.id + " | Unknown function " + functionId + " called");
        }
    }

    function processInput (inputString) {
        // Process the input string here
        // todo: Validate input by prefix /w and find matching  wiki article titles with Wikipedia API
        var suggestions = new Array;
        if (inputString.length > 1 && inputString.length < 140) {
            suggestions.push({'label' : 'Wikipedia', 'functionId': 0});
        }
        return suggestions;
    }
}
