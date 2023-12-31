#chirp
#require './discordrb'
require 'discordrb'
require 'dotenv'
require 'openai'

#load enviroment variables from .env file
Dotenv.load
#load discord bot token and openai access token
discordtoken = ENV['discordtoken']
openaitoken = ENV['openaitoken']
bot = Discordrb::Bot.new token: discordtoken
client = OpenAI::Client.new(access_token: openaitoken)

bot.message(start_with: 'chirp ') do |event|

  #remove the first (triggering) word (-1 is last element in ruby)
  question = "#{event.message}"
  question = question.split(' ')[1..-1].join(' ')
  #print question

  #images
  if question.split(' ')[0] == 'paint'
    #remove word paint
    question = question.split(' ')[1..-1].join(' ')

    #request image
    response = client.images.generate(parameters: { prompt: question, size: "512x512"})
    message = response.dig("data", 0, "url")

    #if the response is empty (mostly due to no being able to generate the request)
    if message.nil?
      event.respond "I'm sorry, I can't do that."
    else
      event.respond message
    end

  #messages
  else
    #chatgpt api call
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: question}],
        temperature: 0.5,
      }
    )
    #get chatgpt message
    message = response.dig("choices", 0, "message", "content")

    if message.length > 1990
      #break up the response into chunks less than 2000 characters (what discord supports) and send them one at a time
      messageArr = message.chars.each_slice(1990).map(&:join)
      messageArr.each do |chunk|
        event.respond chunk
      end
    else
      event.respond message
    end
  end


end

bot.run