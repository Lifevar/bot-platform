# frozen_string_literal: true

module BotPlatform
  module Dialogs
    module Prompts
      class TextPrompt < Prompt
        def on_prompt(ctx, state, options, is_retry)
          assert_turn_context_is_valid ctx
          #assert_dialog_instance_state_is_valid state
          assert_prompt_options_is_valid options

          if is_retry && !options.retry_prompt.nil?
            ctx.send_activity options.retry_prompt
          else
            ctx.send_activity options.prompt
          end
        end

        def on_recognize(ctx, state, options)
          assert_turn_context_is_valid ctx

          result = PromptRecognizerResult.new
          if ctx.activity.type == BotPlatform::Activity::TYPES[:message]
            message = ctx.activity.text
            unless message.nil? || message.empty?
              result.succeeded = true
              result.value = message
            end
          end

          return result
        end
      end
    end
  end
end