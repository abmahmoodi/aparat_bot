require './lib/telegram_bot'
require './lib/api_commander'
require './lib/aparat'

TELEGRAM_TOKEN = 'YOUR TOKEN'

Process.daemon(true)
bot = TelegramBot.new()
aparat = Aparat.new

bot.get_updates do |message|
  command = APICommander.new(message.text)
  if command.start?
    bot.send_message(chat_id: message.chat_id, text: "Please send a keyword with /video for example: /video dog")
  elsif command.video?
    result = aparat.video_by_search(command.video_param)
    bot.send_message(chat_id: message.chat_id, text:  "First item of search: #{result}")
  elsif command.best?
    begin
      result = aparat.best_video(command.best_param)
      result.each do |r|
        bot.send_message(chat_id: message.chat_id, text:  "First item of search: #{r}")
      end
    rescue ParamError
      bot.send_message(chat_id: message.chat_id, text:  "You must send a number with /best")            
    end
  end
end
