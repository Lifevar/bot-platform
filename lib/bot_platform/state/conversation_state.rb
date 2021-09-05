# frozen_string_literal: true

module BotPlatform
  module State
    class ConversationState < BotState
      def initialize(storage)
        super(storage, "conversation_state")
      end

      def get_storage_key(turn_context)
        channel_id = turn_context.activity.channel_id
        conversation_id = turn_context.conversation.id
        "#{channel_id}/conversations/#{conversation_id}"
      end
    end
  end
end