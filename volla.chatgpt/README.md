# ChatGPT Plugin for Volla Launcher

This plugin integrates ChatGPT directly into the Volla Launcher springboard, allowing you to ask questions and get AI-powered responses without leaving your home screen.

## Setup

### 1. Get your OpenAI API Key
1. Visit [OpenAI Platform](https://platform.openai.com/api-keys)
2. Sign in or create an account
3. Create a new API key
4. Copy your API key (it starts with `sk-`)

### 2. Configure the Plugin
1. Open the Volla Launcher springboard (smart text field)
2. Type: `chatgpt set key YOUR_API_KEY`
   - Replace `YOUR_API_KEY` with your actual OpenAI API key
3. Press Enter
4. You should see a confirmation message

### Alternative Setup
If you need help with setup, type: `chatgpt setup` in the springboard for detailed instructions.

## Usage

Once configured, you can use any of these trigger words followed by your question:

- `ask [your question]` - Example: `ask What is the capital of France?`
- `gpt [your question]` - Example: `gpt Explain quantum physics`  
- `chat [your question]` - Example: `chat Write a poem about spring`
- `ai [your question]` - Example: `ai Help me plan a dinner party`

## Features

- **Easy Setup**: Configure your API key directly through the launcher interface
- **Secure Storage**: API key is stored locally using Qt's secure storage
- **Multiple Triggers**: Use `ask`, `gpt`, `chat`, or `ai` to activate
- **Error Handling**: Clear error messages for common issues
- **Rate Limiting**: Handles OpenAI rate limits gracefully

## Commands

- `chatgpt setup` - Show setup instructions
- `chatgpt help` - Show help information  
- `chatgpt config` - Show configuration options
- `chatgpt set key [API_KEY]` - Set your OpenAI API key

## Troubleshooting

### "API key not configured" error
- Make sure you've set your API key using `chatgpt set key YOUR_API_KEY`
- Verify your API key is valid and starts with `sk-`

### "Invalid API key" error  
- Double-check your API key is correct
- Ensure you have sufficient credits in your OpenAI account
- Try setting the key again: `chatgpt set key YOUR_API_KEY`

### "Rate limit exceeded" error
- You've made too many requests in a short time
- Wait a few minutes and try again
- Consider upgrading your OpenAI plan for higher limits

## Privacy & Security

- Your API key is stored locally on your device using Qt's secure storage
- Conversations are sent to OpenAI's servers as per their privacy policy
- No conversation data is stored locally by this plugin

## Version History

- **v0.2**: Added user-friendly API key configuration through the launcher interface
- **v0.1**: Initial release with basic ChatGPT integration
