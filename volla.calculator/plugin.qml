import QtQuick 2.12;

QtObject {

    property var metadata: {
        'id': 'volla_calculator',
        'name': 'Calculator',
        'description': 'This pligin will add a simple caclulator to the springboard',
        'version': 0.1,
        'minLauncherVersion': 3,
        'maxLauncherVersion': 100,
        'resources': [ ]
    }

    function init (inputParameter) {

    }

    function executeInput (inputString, functionId, inputObject) {
        if (functionId === 0) {
            var parameter = inputObject !== undefined ? "weather " + inputObject : "weather " + inputString;
            Qt.openUrlExternally("https://startpage.com/sp/search?query=" + encodeURIComponent(parameter) + "&segment=startpage.volla");
        } else {
            console.warn(metadata.id + " | Unknown function " + functionId + " called");
        }
    }

    function processInput (inputString, callback) {
        var suggestions = new Array;
        if (inputString.length > 1 && inputString.length < 100) {
            var calcResult = evaluateMath(inputString);

            console.debug("Calculator Plugin | calc result: " + calcResult)

            if (calcResult !== NaN) {
                var outputString = inputString + ' = ' + calcResult;
                suggestions = [{'label' : outputString}];
            }
        }
        callback(true, suggestions, metadata.id);
    }

    function evaluateMath(str) {
        for (var i = 0; i < str.length; i++) {
            if (isNaN(str[i]) && !['+', '-', '/', '*', '%', '**'].includes(str[i])) {
                return NaN;
            }
        }

        console.debug("Calculator Plugin | Passed input check ")

        try {
            return Math.eval(str);
        } catch (e) {
            if (e.name !== 'SyntaxError') throw e;
            return NaN;
        }
    }
}
