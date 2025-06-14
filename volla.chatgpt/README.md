# ChatGPT Plugin for Volla Launcher

This plugin integrates OpenAI's ChatGPT directly into the Volla Launcher springboard, allowing you to ask questions and get AI-powered responses without leaving your launcher.

## Features

- Ask questions directly from the springboard
- Multiple trigger words: `gpt`, `ask`, `chat`, `ai`
- Formatted responses with proper HTML display
- Error handling for API issues
- Rate limiting awareness

## Setup

1. **Get an OpenAI API Key**
   - Visit [OpenAI API](https://platform.openai.com/api-keys)
   - Create an account and generate an API key
   - Note: This requires a paid OpenAI account for API access

2. **Configure the Plugin**
   - Open the plugin file: `volla.chatgpt/plugin.qml`
   - Find the line: `property string apiKey: ""`
   - Replace with your API key: `property string apiKey: "your-api-key-here"`

## Usage

### Trigger Words
You can start your queries with any of these words:
- `gpt [your question]`
- `ask [your question]`
- `chat [your question]`
- `ai [your question]`

### Examples
- `gpt What is the capital of France?`
- `ask How do I cook pasta?`
- `chat Tell me a joke`
- `ai Explain quantum physics simply`

### Response Format
The plugin will display responses in a formatted way:
- **ChatGPT:** followed by the AI response
- Clickable link to chat.openai.com for more detailed conversations

## Technical Details

- **Model**: Uses GPT-3.5-turbo by default
- **Max Tokens**: Limited to 150 tokens per response (about 100-120 words)
- **Temperature**: Set to 0.7 for balanced creativity
- **API Endpoint**: OpenAI Chat Completions API

## Error Handling

The plugin handles various error scenarios:
- **Invalid API Key**: Shows authentication error
- **Rate Limiting**: Displays rate limit message
- **Network Issues**: Shows general API error
- **No API Key**: Prompts to configure API key

## Security Notes

- **Never commit your API key to version control**
- Consider using environment variables for production deployments
- Monitor your OpenAI API usage to avoid unexpected charges
- The plugin includes basic HTML escaping for security

## Customization

You can modify the plugin by editing `plugin.qml`:
- Change the model (e.g., to `gpt-4` if you have access)
- Adjust `max_tokens` for longer/shorter responses
- Modify trigger words in the `triggerWords` array
- Customize the response formatting

## Troubleshooting

1. **No response**: Check your API key and internet connection
2. **Rate limit errors**: Wait a few minutes before trying again
3. **Long responses cut off**: Increase `max_tokens` in the plugin
4. **Plugin not triggering**: Make sure you're using one of the trigger words

## License

This plugin follows the same license as the main Volla Launcher plugins repository.
