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

      def create_property(key)
        @storage.data[key.to_sym] = {}
        return @storage.data[key.to_sym]
      end

      def get_property(key)
        return @storage.data[key.to_sym]
      end

      def save_changes(turn_context, force=false)
        assert_turn_context_is_valid turn_context

        #TODO:
      end
    end
  end
end