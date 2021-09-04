# frozen_string_literal: true

module BotPlatform
  module Dialogs
    class Dialog
      attr_reader :dialog_id

      def initialize(dialog_id)
        BotAssert.dialog_id_not_empty dialog_id

        @id = dialog_id
      end

      # start the instance when ready
      def start
      end

      # called after user has new activity
      # params:
      #   dc: DialogContext
      def continue(dc)
        # by default just stop the dialog
        return dc.stop
      end

      # called after dialog was interrupted
      # params:
      #   dc: DialogContext
      def resume(dc)
        # by default just stop the dialog
        stop
      end

      # not-implemented
      def reprompt
      end

      # called by #DialogContext#stop_active_dialog if need to stop dialog
      def stop
      end
    end
  end
end