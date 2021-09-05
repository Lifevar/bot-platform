# frozen_string_literal: true

module BotPlatform
  class MessageFactory
    def self.Text(text)
      return Activity.new Activity::TYPES[:message], {text: text}
    end
  end
end
