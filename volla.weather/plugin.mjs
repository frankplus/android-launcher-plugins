WorkerScript.onMessage = function(message) {

    var textInput = message.textInput
    var actionId = message.actionId
    var actionObj = message.actionObj

    if (actionId === undefined) {
        // todo: Check valid input

        // model.append({ "text": item[0], "action": item[1], "object": item[2], "isFirstSuggestion" : item[3] !== undefined ? item[3] : false})


        WorkerScript.sendMessage( [ { 'pluginId': 'volla.weather',
                                      'actionId': 'volla.weather',
                                      'actionName': 'Weather Forecast',
                                      'actionLocalizedName': { "de_DE": "Wettervorhersage" },
                                      'actionType': 20030 } // Execute plugin function
                                  ] )
    } else if (actionId === 'volla.weather') {
        // todo: open weather app


        WorkerScript.sendMessage()
    }
}

