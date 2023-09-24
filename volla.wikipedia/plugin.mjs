WorkerScript.onMessage = function(message) {

    var textInput = message.textInput
    var actionId = message.actionId
    var actionObj = message.actionOhj

    if (actionId === undefined) {
        // todo: Check valid input


        WorkerScript.sendMessage( { 'pluginId': 'volla.wikipedia',
                                    'actionId': 'volla.wikipedia',
                                    'actionName': 'Wikipedia article',
                                    'actionLocalizedName': { "de_DE": "Wikipedia-Artikel" },
                                    'actionObj' : ''} ) // Coul be the id of the location
    } else {
        // todo: open wikipedia article


        WorkerScript.sendMessage()
    }
}
