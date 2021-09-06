# frozen_string_literal: true

module BotPlatform
  module Dialogs
    class DialogState
      attr_accessor :dialog_stack

      def initialize(state = [])
        @dialog_stack = state
      end
    end
  end
end