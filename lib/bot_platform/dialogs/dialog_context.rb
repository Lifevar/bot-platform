# frozen_string_literal: true

module BotPlatform
  module Dialogs
    class DialogContext
      attr_accessor :dialogs, :context, :stack
      def initialize(dialogs, turn_context, dialog_state)
        BotAssert.dialog_set_is_valid dialogs
        BotAssert.turn_context_is_valid turn_cotnext
        BotAssert.dialog_state_is_valid dialog_state

        @dialogs = dialogs
        @context = turn_context
        @stack = dialog_state.dialog_stack
      end

      def active_dialog
        return nil if @stack.nil? || @stack.length==0
        @stack.last
      end

      def reprompt
        dialog = active_dialog
        if dialog != nil
          dialog.reprompt(context)
        end
      end

      def stop_active_dialog
        dialog = active_dialog
        if dialog != nil
          dialog.stop
          @stack.pop
        end
      end
    end
  end
end