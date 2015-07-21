require './lib/string'

class ParamError < StandardError; end
  
class APICommander
  attr_accessor :command
  
  def initialize(command)
    @command = command  
  end
  
  def start?
    true unless command[0..5].downcase != '/start'
  end
  
  def video?
    true unless command[0..6].downcase != '/video '
  end
  
  def best?
    true unless command[0..5].downcase != '/best '
  end
  
  def video_param
    command[7..-1]
  end
  
  def best_param
    if !command[6..-1].is_i?
      raise ParamError, 'Best param error.'
    end

    command[6..-1].to_i
  end
end