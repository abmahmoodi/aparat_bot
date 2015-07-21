require 'typhoeus'
require 'multi_json'
require './lib/aparat'
require './lib/string'
require './lib/api_commander'
require './lib/message'

class  TelegramBot
  attr_accessor :offset, :token
  
  END_POINT = 'https://api.telegram.org'
  
  def initialize(token)
    @offset = 0  
    @token = token
  end

  def api_response(response)
    if response.code < 500
      @body = response.response_body

      data = MultiJson.load(@body)
      @success = data["ok"]

      if @success
        @result = data["result"][0]
      else
        false
      end
    else
      # TODO: Raise an exception
    end
  end
  
  def get_updates(&block)
    loop do
      request = run_api('getUpdates', {offset: @offset, timeout: 60})
      begin
        res = api_response(request)
        if (res != nil) and (res != false)
          message = Message.new(res)
          @offset = message.update_id + 1
          yield message
        end
      rescue Exception => e
        p e.message
      end
    end
  end
  
  def send_message(chat_id:, text:)
    run_api('sendMessage', {chat_id: chat_id, text: text})
  end
  
  private
  def run_api(api_method, params)
    Typhoeus.post(
        "#{END_POINT}/bot#{@token}/#{api_method}",
        headers: {
                "User-Agent" => "AparatBot/0.1.0",
                "Accept" => "application/json"
              },
        body: params
      )
  end
end

