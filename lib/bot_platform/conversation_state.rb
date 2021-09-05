# frozen_string_literal: true

module BotPlatform
  class ConversationState
    include Singleton
    attr_accessor :conversation


    def initialize
      user_id = turn_context.from.user_id
      room_id = turn_context.from.room_id
      key = "#{user_id}@#{room_id}"
      user_state = MemoryStorage.instance.get(key) || {}
      conversation_state = user_state[:conversation] || {}
      user_state[:conversation] = conversation_state

      MemoryStorage.instance.set(key, user_state)
    end

    def get(turn_context)
      user_id = turn_context.from.user_id
      room_id = turn_context.from.room_id
      key = "#{user_id}@#{room_id}"

      MemoryStorage.instance.get(key)[:conversation]
    end

    def set(context, key, value)
      MemoryStorage.instance.get(context).set(key, value)
    end
  end
end