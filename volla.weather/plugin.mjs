WorkerScript.onMessage = function(message) {

    var textInput = message.textInput
    var actionId = message.actionId
    var actionObj = message.actionOhj

    if (actionId === undefined) {
        // todo: Check valid input


        WorkerScript.sendMessage( { 'pluginId': 'volla.weather',
                                    'actionId': 'volla.weather',
                                    'actionName': 'Weather Forecast',
                                    'actionLocalizedName': { "de_DE": "Wettervorhersage" },
                                    'actionObj' : ''} ) // Coul be the id of the location
    } else {
        // todo: open weather app


        WorkerScript.sendMessage()
    }
}

