# Chirp  

Chirp uses the Discord and OpenAI APIs to receive and answer ChatGPT prompts from Discord.

## Running  

### Prerequisites  
Running requires creating a [Discord Application](https://discord.com/developers/docs/getting-started), as well as an [OpenAI API key](https://platform.openai.com/account/api-keys). The Discord bot will also need to be added to a server.

Put the Discord token and OpenAI access tokens in a .env file with the following syntax:  
```bash
discordtoken='yourkeyhere'
openaitoken='yourkeyhere'
```  

There are three required gems to install:  
- [discordrb](https://github.com/shardlab/discordrb)  
- [dotenv](https://github.com/bkeepers/dotenv)  
- [ruby-openai](https://github.com/alexrudall/ruby-openai)  

### Running:  
After installing all prerequisites, the program can be run with:  
```bash
ruby chirp.rb
```

## Use:  

### Messages:  
Ask chirp a question using the following format in discord:
```bash
chirp [question body here]
```  
Example usage:  

![Example Usage](example.png?raw=true)

### Images:  
Chirp supports DALLE images using the following format:  
```bash
chirp paint [prompt here]
```  
It returns a URL, which should be automatically embedded by Discord.  

Example usage:  

![Example Usage](example2.png?raw=true)