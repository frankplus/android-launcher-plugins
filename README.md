# Volla Launcher Plugins

Reporistory for additional skills of the smart text field on the springboard of the Volla Launcher. Thirs party developeers can provide their plugin by adding a directory and entry in the json file for available plugins. The API is under construction.

## Basics

1. Each plugin has it's own directory with a unique name derived from the plhuin id.
2. Each plugin mast be listed in the `VollaPluginList.json` with its metadata

```
{
  "id":"volla_weather",
  "name":"Weather Forecast",
  "version":0.1,
  "description":"It will add feature to get Weather Forecast directly from Springboard", 
  "downloadUrl": "https://raw.githubusercontent.com/HelloVolla/android-launcher-plugin/master/volla.weather/plugin.qml",
  "minLauncherVersion": 2.3,
  "maxLauncherVersion": 10
}
```

The version property is not used by the launcher, yet.

## Plugin

The core element of the plugin is a QtObject with the name `plugin.qml` on the root level of the plugin's directory. This object has three main elements:

### Metadata

The mandatory property is the metadata dictionary. It contains the id of the plugin, the name and description. Resources are not used by the launcher, yet. The intention is to add furhter Ui elemgents, images, scripts or libaraires for more porwerful features.

```
property var metadata: {  
  'id': 'volla_weather',
  'name': 'Weather Forecast',  
  'description': 'It will add feature to get Weather Forecast directly from Springboard',  
  'version': 0.1,  
  'minLauncherVersion': 2.3,  
  'maxLauncherVersion': 100,  
  'resources': [ ]  
}
```

### Process input
  
The javascript method to process the entered string in the smart textfield of the springboard. It returns matching functions or autocompletions, which appear under the smart textvield. The callback function allows asynchronous operations like web service requests.

```
function processInput (inputString, callback) {
   var suggestions = new Array;
   if (inputString.length > 1 && inputString.length < 100) {
      suggestions = [{'label' : 'Weather', 'functionId': 0}];

      if ('Berlin'.startsWith(inputString) && !inputString.startsWith('Berlin')) {
         suggestions.push({'label' : 'Berlin', 'object' : 'Berlin DE'});
      }

      callback(true, suggestions, metadata.id);
   }
}```

### Process function

The javascript method to process the function selection. If an autocompletion was selected, it can be processed instead or together with the entered string into the smart textfield of the springboard.

```
function executeInput (inputString, functionId, inputObject) {
  if (functionId === 0) {
    var parameter = inputObject !== undefined ? "weather " + inputObject : "weather " + inputString
    Qt.openUrlExternally("https://startpage.com/sp/search?query=" + encodeURIComponent(parameter) + "&segment=startpage.volla")
  } else {
    console.warn(metadata.id + " | Unknown function " + functionId + " called")
  }
}
```

## Init

The init method can be used to execute some expensive loading of resources, that is only done once, after the plugin is created.

```
function init (inputParameter) {
  // todo: Load city ressouces
}
```

## To be defined and implemented 

1. Another output option beyond functions and autocompletions a view element with a result of a function without the need to open a web page or another app.
2. Using and loading additional resources like QML objects, images, scripts.

Ideas of community developer to improve the API and its use in the launcher is highly appreciated.
