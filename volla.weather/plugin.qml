import QtQuick 2.12;

QtObject {
    id: volla_weather;
    property string jsonArrayString: JSON.stringify([
       {"name": "Aachen","state": "North Rhine-Westphalia"},{"name": "Abenberg","state": "Bavaria"},{"name": "Achim","state": "Lower Saxony"
       },{"name": "Albstadt","state": "Baden-Württemberg"},{"name": "Alpirsbach","state": "Baden-Württemberg"},{"name": "Altdorf bei Nürnberg","state": "Bavaria"},
       {"name": "Altenkirchen","state": "Rhineland-Palatinate"},{"name": "Annaburg","state": "Saxony-Anhalt"}, {"name": "Balingen","state": "Baden-Württemberg"},
       {"name": "Ballenstedt","state": "Saxony-Anhalt"},{"name": "Bedburg","state": "North Rhine-Westphalia"},{"name": "Berlin","state": "Berlin"},
       {"name": "Biedenkopf","state": "Hesse"},{"name": "Burladingen","state": "Baden-Württemberg"}])

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

    function isValidCityName(input) {
        // Check if the input contains only alphabetic characters and is not empty
        return /^[a-zA-Z\s]*$/.test(input) && input.length > 0;
    }

    function processInput (inputString) {
        // Process the input string here
        // Validate input for city names fpr autocompretion suggestions
        // Return an object containing the autocompletion or methods/functions
        var suggestions = new Array
        if(!isValidCityName(inputString)){
            return suggestions
        }

        var jsonArray = JSON.parse(jsonArrayString);

        if (inputString.length > 1 && inputString.length < 100) {
            suggestions = [{'label' : 'Weather', 'functionId': 0}];


            for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];
                console.log("Object " + (i + 1) + ":");
                console.log("Value of name:", jsonObject.name + "  Value of state:"+sonObject.state);
                if (jsonObject.name.startsWith(inputString)) {
                    suggestions.push([{'label' : jsonObject.name, 'object' :jsonObject.state }])
                }
            }
        }
        return suggestions
    }
}
