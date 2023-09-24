import QtQuick 2.12

QtObject {
    id: volla_wikipedia

    property var metadata: {
        'name': 'Wikipedia',
        'description': 'It will add feature to open Wikipedia from Springboard',
        'version': 0.1,
        'minLauncherVersion': 3,
        'maxLauncherVersion': 100,
        'resources': [ ]
    }

    function init (inputParameter) {
        // todo: Load wiki articles for system language
    }

    function processInput (inputString) {
        // Process the input string here
        // todo : Validate input by prefix and/or match to wiki article title

        return {
            "Open Wikipedia": function (inputString) {
                // todo: Need to launch weather forecast app.
            }
        }
    }
}
