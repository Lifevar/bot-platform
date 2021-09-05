# frozen_string_literal: true

module BotPlatform
  module Storage
    module Storageable
      attr_accessor :data, :_user_state, :coversation_state, :dialog_state

      def set(key, value, exipred=false)
      end

      def get(key)
      end

      def del(key)
      end

      def read(keys)
      end

      def write(changes)
      end

      def user_state
        get(:_user_state)
      end

      def user_state=(state)
        set(:_user_state, state)
      end

    end
  end
end
