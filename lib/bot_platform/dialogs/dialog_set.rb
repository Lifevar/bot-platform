# frozen_string_literal: true

module BotPlatform
  module Dialogs
    class DialogSet
      include BotPlatform::Asserts

      attr_accessor :dialogs, :dialog_state

      def initialize()
#        assert_dialog_state_is_not_null dialog_state
#        @dialog_state = dialog_state
        @dialog_state = BotPlatform::Dialogs::DialogState.new
        @dialogs = {}
      end

      def add(dialog)
        assert_dialog_is_valid dialog
        assert_dialog_is_uniq @dialogs, dialog.id

        @dialogs[dialog.id.to_sym] = dialog
        return self
      end

      def create_dialog_context(turn_context)
        assert_turn_context_is_valid turn_context

        state = @dialog_state

        return DialogContext.new self, turn_context, state
      end

      def find(dialog_id)
        return @dialogs[dialog_id.to_sym]
      end
    end
  end
end