function metadata() {
    'name': 'Wikipedia',
    'description': 'It will add feature to open Wikipedia from Springboard',
    'version': 0.1,
    'minLauncherVersion':,
    'maxLauncherVersion':

}


/*
This is sample code need to execute at client side to start this script
const item = init("testString");
const methodNames = Object.keys(item);
const methods = Object.values(item);
console.log("returned item "+ methodNames + "  "+methods);
if (typeof item[methodNames] === 'function') {
    console.log(`Executing ${methodNames}: ${item[methodNames]()}`);
}
*/


function init(inputParameter){
    const stringProcessor = processInput(inputParameter);
    return stringProcessor;
}


function processInput(inputString) {
    // Process the input string here
    // Todo : Need to validate for some regular expression
    // Return an object containing the methods/functions
    return {
        "Open Wikipedia": function(inputString) { Qt.openUrlExternally("https://en.wikipedia.org/wiki/"+inputString); }
    };
}

