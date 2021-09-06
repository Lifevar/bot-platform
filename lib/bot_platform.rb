# frozen_string_literal: true

require_relative "bot_platform/version"
require_relative "bot_platform/activity"
require_relative "bot_platform/adapter"
require_relative "bot_platform/asserts"
require_relative "bot_platform/message_factory"
require_relative "bot_platform/turn_context"
require_relative "bot_platform/channels"
require_relative "bot_platform/dialogs"
require_relative "bot_platform/storage/storageable"
require_relative "bot_platform/storage/memory_storage"
require_relative "bot_platform/state/bot_state"
require_relative "bot_platform/state/conversation_state"
require_relative "bot_platform/state/user_state"

module BotPlatform
  class Error < StandardError; end

  def self.greet
    "Welcome to Bot Platform"
  end
end
