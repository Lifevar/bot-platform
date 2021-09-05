# frozen_string_literal: true

module BotPlatform
  module Dialogs
    class Dialog
      include BotPlatform::Asserts
      END_OF_TURN = "end_of_turn".freeze

      attr_reader :id

      def initialize(dialog_id)
        assert_dialog_id_is_valid dialog_id

        @id = dialog_id
      end

      # abstract
      # start the instance when ready
      def start(dc)
        raise "unimplemented"
      end

      # called after user has new activity
      # params:
      #   dc: DialogContext
      def continue(dc)
        # by default just stop the dialog
        return dc.stop
      end

      # called after pre-dialog was poped
      # params:
      #   dc: DialogContext
      def resume(dc, result)
        # by default just stop the dialog
        stop result
      end

      # not-implemented
      def reprompt(turn_context, instance)
      end

      # called by #DialogContext#stop_active_dialog if need to stop dialog
      def stop(result)
      end
    end
  end
end