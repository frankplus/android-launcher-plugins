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

    function executeInput (inputString, functionId, inputObject) {
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
        var wikiArticleArray = new Array;
        var wikiArticle = getWikiArticles(inputString);
        console.log("Wiki Plugin | wiki wikiArticle "+wikiArticle)
        wikiArticleArray = wikiArticle["prefixsearch"]
        for (var i = 0; i < wikiArticleArray.length; i++) {
            suggestions.push({'label' : wikiArticleArray[i].title, 'functionId': 0});
            console.log("Wiki Plugin | wiki items "+wikiItems[i].title)
        }
        return suggestions;
    }

    function getWikiArticles (inputParam){
        console.debug("Wiki Plugin | setting wiki request ")
        var xmlRequest = new XMLHttpRequest();
        xmlRequest.onreadystatechange = function() {
            if (xmlRequest.readyState === XMLHttpRequest.DONE) {
                console.debug("Wiki Plugin | got wiki request responce"+xmlRequest.status)
                if (xmlRequest.status === 200) {
                    console.log("Wiki Plugin | wiki responste status 200 "+xmlRequest.responseText)
                    var wiki = JSON.parse(xmlRequest.responseText)
                    var query = wiki.query;
                    var wikiItems = new Array
                    wikiItems = query["prefixsearch"]
                    for (var i = 0; i < wikiItems.length; i++) {
                        console.log("Wiki Plugin | wiki items "+wikiItems[i].title)
                    }
                } else {

                    console.error("Wiki Plugin | Error retrieving wiki: ", xmlRequest.status, xmlRequest.statusText)
                }
                return query;
            }
        };
        var wikiArturl = "https://en.wikipedia.org/w/api.php?action=query&format=json&list=prefixsearch&pssearch="+inputParam;
         console.log("Wiki Plugin | sending get wiki article request on url "+wikiArturl)
        xmlRequest.open("GET", wikiArturl)
        xmlRequest.send();

    }
}
