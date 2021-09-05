# frozen_string_literal: true

module BotPlatform
  module Dialogs
    class DialogResult
      STATUS_TYPES = {
        :empty => 0,
        :complete => 1,
        :canceled => 2,
      }

      attr_reader :status, :result

      def initialize(status, result=nil)
        raise "invalid dialog result status" if !STATUS_TYPES.key?(status)

        @status = status
        @result = result
      end
    end
  end
end