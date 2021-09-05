module BotPlatform
  module Dialogs
    class DialogState
      attr_accessor :dialog_stack

      def initialize
        @dialog_stack = []
      end
    end
  end
end