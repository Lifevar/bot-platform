# frozen_string_literal: true

require_relative "bot_platform/version"

module BotPlatform
  class Error < StandardError; end

  def self.greet
    "Welcome to Bot Platform"
  end
end
