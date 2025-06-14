import QtQuick 2.12;

QtObject {

    property var metadata: {
        'id': 'volla_chatgpt',
        'name': 'ChatGPT',
        'description': 'This plugin integrates ChatGPT for AI-powered responses directly from the springboard',
        'version': 0.1,
        'minLauncherVersion': 3,
        'maxLauncherVersion': 100,
        'resources': [ ]
    }

    // You'll need to set your OpenAI API key here
    // For security, consider using environment variables or secure storage in production
    property string apiKey: ""
    property string apiUrl: "https://api.openai.com/v1/responses"
    property string model: "gpt-4.1"

    function init (inputParameter) {
        console.debug("ChatGPT Plugin | Initialized");
    }

    function executeInput (inputString, functionId, inputObject) {
        // Handle execution of selected suggestions
    }

    function processInput (inputString, callback, inputObject) {
        console.debug("ChatGPT Plugin | Process input string: " + inputString);
        var suggestions = new Array;
        
        // Check if input starts with "gpt", "ask", or "chat" to trigger ChatGPT
        var triggerWords = ["gpt", "ask", "chat", "ai"];
        var shouldTrigger = false;
        var query = inputString.toLowerCase().trim();
        
        for (var i = 0; i < triggerWords.length; i++) {
            if (query.startsWith(triggerWords[i] + " ") || query === triggerWords[i]) {
                shouldTrigger = true;
                // Remove the trigger word from the query
                if (query.startsWith(triggerWords[i] + " ")) {
                    query = inputString.substring(triggerWords[i].length + 1).trim();
                }
                break;
            }
        }
        
        if (shouldTrigger && query.length > 0) {
            if (apiKey === "") {
                suggestions.push({
                    'label': '<p><b>ChatGPT:</b> API key not configured</p><p>Please set your OpenAI API key in the plugin settings</p>'
                });
                callback(true, suggestions, metadata.id);
                return;
            }
            
            getChatGPTResponse(query, callback);
        } else if (shouldTrigger && query.length === 0) {
            suggestions.push({
                'label': '<p><b>ChatGPT:</b> Type your question after "gpt", "ask", or "chat"</p><p>Example: "ask What is the weather like?"</p>'
            });
            callback(true, suggestions, metadata.id);
        } else {
            callback(true, suggestions, metadata.id);
        }
    }

    function getChatGPTResponse(query, callback) {
        console.debug("ChatGPT Plugin | Making API request for: " + query);
        
        var request = new XMLHttpRequest();
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                console.debug("ChatGPT Plugin | API response status: " + request.status);
                
                if (request.status === 200) {
                    try {
                        var response = JSON.parse(request.responseText);
                        var answer = "";
                        
                        // Parse the new response format
                        if (response && response.length > 0 && response[0].content && response[0].content.length > 0) {
                            answer = response[0].content[0].text.trim();
                        } else {
                            throw new Error("Unexpected response format");
                        }
                        
                        // Format the response for display
                        var outputString = '<p><b>ChatGPT:</b></p><p>' + escapeHtml(answer) + '</p>';
                        
                        var suggestions = [{
                            'label': outputString,
                            'link': 'https://chat.openai.com'
                        }];
                        
                        console.debug("ChatGPT Plugin | Response received successfully");
                        callback(true, suggestions, metadata.id);
                    } catch (e) {
                        console.error("ChatGPT Plugin | Error parsing response: " + e);
                        var errorSuggestions = [{
                            'label': '<p><b>ChatGPT:</b> Error parsing response</p>'
                        }];
                        callback(false, errorSuggestions, metadata.id);
                    }
                } else if (request.status === 401) {
                    var errorSuggestions = [{
                        'label': '<p><b>ChatGPT:</b> Invalid API key</p><p>Please check your OpenAI API key</p>'
                    }];
                    callback(false, errorSuggestions, metadata.id);
                } else if (request.status === 429) {
                    var errorSuggestions = [{
                        'label': '<p><b>ChatGPT:</b> Rate limit exceeded</p><p>Please try again later</p>'
                    }];
                    callback(false, errorSuggestions, metadata.id);
                } else {
                    console.error("ChatGPT Plugin | API error: ", request.status, request.statusText);
                    var errorSuggestions = [{
                        'label': '<p><b>ChatGPT:</b> API error (' + request.status + ')</p><p>Please try again later</p>'
                    }];
                    callback(false, errorSuggestions, metadata.id);
                }
            }
        }
        
        // Prepare the request payload
        var payload = {
            "model": model,
            "instructions": "Provide helpful and concise responses.",
            "input": query
        };
        
        request.open("POST", apiUrl);
        request.setRequestHeader("Content-Type", "application/json");
        request.setRequestHeader("Authorization", "Bearer " + apiKey);
        request.send(JSON.stringify(payload));
    }
    
    function escapeHtml(text) {
        // Basic HTML escaping to prevent issues with special characters
        return text.replace(/&/g, "&amp;")
                  .replace(/</g, "&lt;")
                  .replace(/>/g, "&gt;")
                  .replace(/"/g, "&quot;")
                  .replace(/'/g, "&#39;");
    }
}
