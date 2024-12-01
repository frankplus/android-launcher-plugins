import QtQuick 2.12;

QtObject {

    property var metadata: {
        'id': 'volla_wikipedia',
        'name': 'Wikipedia',
        'description': 'It will add feature to open Wikipedia from Springboard',
        'version': 0.3,
        'minLauncherVersion': 3,
        'maxLauncherVersion': 100,
        'resources': [ ]
    }

    function init (inputParameter) {
        // todo: Load any resource if necessary
    }

    function executeInput (inputString, functionId, inputObject) {
        // Process the function here for a selected entity
        if (functionId === 0) {
            var parameter = inputObject !== undefined ? inputObject.title : inputString;
            var locale = Qt.locale().name;
            var url = "https://"+ locale.split('_')[0] + '.wikipedia.org/wiki/' + parameter;
            console.debug('Wiki Plugin | Will open ' + url);
            Qt.openUrlExternally(url);
        } else {
            console.warn(metadata.id + " | Unknown function " + functionId + " called");
        }
    }

    function processInput (inputString, callback, inputObject) {
        // Process the input string here to provide suggestions
        // todo: Validate input by prefix /w
        var suggestions = new Array
        var locale = Qt.locale().name

        // Use case 2: An autocompletion and entity suggestion was selected by the user.
        //             The resut can be a live cntent or function, in this case it's a live content
        if (inputObject !== undefined && inputObject.pluginId === metadata.id) {
            var url = "https://"+ locale.split('_')[0]
                    + ".wikipedia.org/api/rest_v1/page/summary/"
                    + inputObject.entity["title"]
            var summaryRequest = new XMLHttpRequest();
            summaryRequest.onreadystatechange = function() {
                if (summaryRequest.readyState === XMLHttpRequest.DONE) {
                    console.debug("Wiki Plugin | Summary request responce " + summaryRequest.status)
                    if (summaryRequest.status === 200) {
                        console.log("Wiki Plugin | Summary request response text " + summaryRequest.responseText)
                        var wiki = JSON.parse(summaryRequest.responseText)
                        var output
                        var link
                        try {
                            output = wiki.extract
                            link = wiki.content_urls.mobile.page
                            if (wiki.thunbnail) output = output + "<p><img src=\"" + wiki.thunbnail.source + "\"></p><p>"
                            suggestions.push({'label' : output, 'link': link});
                        } catch (err) {
                            console.error("Wiki Plugin | Couldn't read summary properties: " + err)
                        }
                        callback(true, suggestions, metadata.id)
                    }

                }
            }
            summaryRequest.open("GET", url)
            summaryRequest.send()
        // Use case 1: User is typing to find a wiki article
        } else if (inputObject === undefined && inputString.length > 1  && inputString.length < 140) {
            console.debug("Wiki Plugin | Sending wiki request ")
            var wikiArturl = "https://" + locale.split('_')[0]
                           + ".wikipedia.org/w/api.php?action=query&format=json&list=prefixsearch&pssearch="
                           + inputString
            var xmlRequest = new XMLHttpRequest();
            xmlRequest.onreadystatechange = function() {
                if (xmlRequest.readyState === XMLHttpRequest.DONE) {
                    console.debug("Wiki Plugin | Article request responce " + xmlRequest.status)
                    if (xmlRequest.status === 200) {
                        console.log("Wiki Plugin | wiki responste status 200 "+xmlRequest.responseText)
                        var wiki = JSON.parse(xmlRequest.responseText)
                        var query = wiki.query
                        var wikiItems = query["prefixsearch"]
                        for (var i = 0; i < wikiItems.length; i++) {
                            suggestions.push({'label' : metadata.name + " : " + wikiItems[i].title, 'object': wikiItems[i]});
                            console.log("Wiki Plugin | wiki items " + wikiItems[i].title)
                        }
                        console.log("Wiki Plugin | Calling callback true")
                        callback(true, suggestions, metadata.id)
                    } else {
                        callback(false, suggestions, metadata.id)
                        console.log("Wiki Plugin | Calling callback true")
                        console.error("Wiki Plugin | Error retrieving wiki: ", xmlRequest.status, xmlRequest.statusText)
                    }
                }
            }
            xmlRequest.open("GET", wikiArturl)
            xmlRequest.send()
        } else {
            callback(true, suggestions, metadata.id)
        }
    }
}
