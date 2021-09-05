# frozen_string_literal: true

module BotPlatform
  module Dialogs
    class DialogInstance
      attr_reader :dialog_id
      attr_accessor :state

      def initialize(dialog_id)
        @dialog_id = dialog_id
        @state = {}
      end
    end
  end
end