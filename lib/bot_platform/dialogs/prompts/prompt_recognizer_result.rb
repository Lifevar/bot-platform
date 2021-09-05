# frozen_string_literal: true

module BotPlatform
  module Dialogs
    module Prompts
      class PromptRecognizerResult
        attr_accessor :succeeded, :value

        def initialize
          @succeeded = false
          @value = nil
        end
      end
    end
  end
end