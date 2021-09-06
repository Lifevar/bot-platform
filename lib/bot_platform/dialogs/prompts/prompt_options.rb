# frozen_string_literal: true

module BotPlatform
  module Dialogs
    module Prompts
      class PromptOptions
        attr_accessor :prompt, :retry_prompt, :choices, :validations

        def initialize(prompt:nil)
          @prompt = prompt
        end
      end
    end
  end
end