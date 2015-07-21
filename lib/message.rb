class Message
  attr_accessor :message
  
  def initialize(message)
    @message = message  
  end
  
  def text
    @message['message']['text']
  end
  
  def chat_id
    @message['message']['chat']['id'].to_i
  end
  
  def update_id
    @message['update_id'].to_i
  end
end