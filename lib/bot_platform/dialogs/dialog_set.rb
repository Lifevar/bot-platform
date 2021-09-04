# frozen_string_literal: true

module BotPlatform
  module Dialogs
    class DialogSet
      attr_accessor :dialogs, :dialog_state

      def initialize(dialog_state)
        
        BotAssert.dialog_state_is_not_null dialog_state
        @dialog_state = dialog_state
        @dialogs = {}
      end

      def add(dialog)
        BotAssert.dialog_is_valid dialog
        BotAssert.dialog_is_uniq @dialogs, dialog.id 

        @dialogs[dialog.id.to_sym] = dialog
        return self
      end

      def create_dialog_context(turn_context)
        BotAssert.turn_context_is_valid turn_context

        state = @dialog_state.get turn_context

        return DialogContext.new self, turn_context, state
      end

      def find(dialog_id)
        return @dialogs[dialog_id.to_sym]
      end
    end
  end
end