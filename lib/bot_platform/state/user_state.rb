# frozen_string_literal: true

module BotPlatform
  module State
    class UserState < BotState
      def initialize(storage)
        super(storage, "user_state")
      end

      def get_storage_key(turn_context)
        channel_id = turn_context.activity.channel_id
        user_id = turn_context.from.user_id
        "#{channel_id}/users/#{user_id}"
      end
    end
  end
end