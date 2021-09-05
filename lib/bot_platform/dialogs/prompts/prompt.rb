# frozen_string_literal: true

module BotPlatform
  module Dialogs
    module Prompts
      class Prompt < Dialog
        attr_reader :validator

        def initialize(dialog_id, validtor=nil)
          super(dialog_id)
          @validator = validator
        end

        def start(dc, options)
          assert_dialog_context_is_valid dc
          assert_prompt_options_is_valid options

          state = dc.active_dialog.state
          state[:options] = options
          state[:state] = {}

          on_prompt(dc.turn_context, state[:state], state[:options], false)
          return BotPlatform::Dialogs::DialogResult.new :complete
        end

        def continue(dc)
          assert_dialog_context_is_valid dc

          if dc.turn_context.activity.type != BotPlatform::Activity::TYPES[:message]
            # do nothing
            return BotPlatform::Dialogs::DialogResult.new :complete
          end

          instance = dc.active_dialog
          state = instance.state[:state]
          options = instance.state[:options]

          recognized = on_recognize(dc.turn_context, state, options)

          is_valid = false

          if !@validator.nil?
            prompt_validator_ctx = PromptValidatorContext.new dc.turn_context, recognized, state, options
            is_valid = @validator.send(prompt_validator_ctx)
          elsif recognized.succeeded
            is_valid = true
          end

          if is_valid
            return dc.stop_dialog(recognized.value)
          else
            return on_prompt(dc.turn_context, state, options, true)
          end
        end

        def resume(dc, result=null)
          assert_dialog_context_is_valid dc

          reprompt(dc.turn_context, dc.active_dialog)
          return BotPlatform::Dialogs::DialogResult.new :complete
        end

        def repromp(ttx, instance)
          assert_turn_context_is_valid ttx
          assert_dialog_instance_is_valid instance

          state = instace.state[:state]
          options = instance.state[:options]

          on_prompt(ttx, state, options, false)
        end

        def on_prompt(turn_context, state, options, is_retry)
          raise "not implemented(abstrct in super)"
        end

        def on_recognize(turn_context, state, options, is_retry)
          raise "not implemented(abstrct in super)"
        end

      end
    end
  end
end