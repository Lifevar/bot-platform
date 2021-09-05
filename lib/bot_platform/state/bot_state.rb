# frozen_string_literal: true

module BotPlatform
  module State
    class BotState
      include BotPlatform::Asserts

      attr_accessor :storage, :service_key
      def initialize(storage, service_key)
        @storage = storage
        @service_key = service_key
      end

      def save_changes(turn_context, force=false)
        assert_turn_context_is_valid turn_context

        #TODO:
      end
    end
  end
end