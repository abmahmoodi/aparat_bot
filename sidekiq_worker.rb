require './lib/telegram_bot'
require 'sidekiq'

class SidekiqWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform
		bot = TelegramBot.new('91239886:AAHtIt5Opw7gPZ0K7AJqGPk95owSiJ-Q8R0')
		bot.update_me
	end

	def redis
    @redis ||= Redis.new
  end
end

# SidekiqWorker.perform_async

