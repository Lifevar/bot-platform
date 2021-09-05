# frozen_string_literal: true

module BotPlatform
  module Dialogs
    class DialogContext
      include BotPlatform::Asserts

      attr_accessor :dialogs, :turn_context, :dialog_stack

      def initialize(dialogs, turn_context, dialog_state)
        assert_dialog_set_is_valid dialogs
        assert_turn_context_is_valid turn_context
        assert_dialog_state_is_valid dialog_state

        @dialogs = dialogs
        @turn_context = turn_context
        @dialog_stack = dialog_state.dialog_stack
      end

      def active_dialog
        return nil if @dialog_stack.nil? || @dialog_stack.length==0
        @dialog_stack.last
      end

      def start_dialog(dialog_id, options)
        assert_dialog_id_is_valid dialog_id

        dialog = @dialogs.find(dialog_id)
        raise "dialog(id=#{dialog_id}) cannot be found." if dialog.nil?
        dialog_instance = DialogInstance.new dialog_id
        @dialog_stack.push dialog_instance

        dialog.start self, options
      end

      def prompt(dialog_id, options)
        assert_dialog_id_is_valid dialog_id
        assert_is_not_empty options

        start_dialog dialog_id, options
      end

      def continue_dialog
        instance = active_dialog 
        if instance != nil
          dialog = @dialogs.find instance.dialog_id
          if dialog
            return dialog.continue self
          end
        end

        return DialogResult.new :empty
      end

      def stop_dialog(result)
        if @dialog_stack.any?
          @dialog_stack.pop
        end
        dialog = active_dialog

        #previous dialog
        if dialog
          dialog.resume self
        else
          return DialogResult.new :complete, result
        end
      end

      # stop all dialogs in the stack
      def stop_all
        if @dialog_stack.any?
          @dialog_stack.each do |dialog|
            dialog.stop
          end
          @dialog_stack = []
        end
      end

      # stop active dialog and start a new dialog by given
      def replace_dialog(dialog_id, options)
        unless active_dialog.nil?
          @dialog_stack.pop
        end

        return start_dialog(dialog_id, options)
      end

      def reprompt
        dialog = active_dialog
        if dialog != nil
          dialog.reprompt(turn_context)
        end
      end

      def stop_active_dialog
        dialog = active_dialog
        if dialog != nil
          dialog.stop
          @dialog_stack.pop
        end
      end
    end
  end
end