# frozen_string_literal: true

require 'securerandom'
require 'logger'

module BotPlatform
  module Dialogs
    class WaterfallDialog < Dialog
      include BotPlatform::Asserts

      LOGLEVELS = %w[DEBUG INFO WARN ERROR FATAL UNKNOWN].freeze
      attr_reader :steps

      def initialize(dialog_id, actions)
        super(dialog_id)
        @steps = actions.nil? ? [] : actions
        @logger = Logger.new(STDOUT)
        
        level ||= LOGLEVELS.index ENV.fetch("BOT_LOG_LEVEL","WARN")
        level ||= Logger::WARN
        @logger.level = level
      end

      def version
        return "#{@id}:#{@steps.count}"
      end

      def add_step(step)
        @steps.push step
        return self
      end

      def start(dc, options=nil)
        assert_dialog_context_is_valid dc

        state = dc.active_dialog.state
        instance_id = SecureRandom.uuid

        state[:options] = options
        state[:values] = {}
        state[:instace_id] = instance_id

        # first step
        run_step(dc, 0, DialogReason::BEGIN_CALLED, nil)
      end

      def continue(dc)
        @logger.debug "continue dc:#{dc.inspect}"
        assert_dialog_context_is_valid dc

        if dc.turn_context.activity.type != Activity::TYPES[:message]
          return DialogResult.new :complete
        end

        return resume(dc, DialogReason::CONTINUE_CALLED, dc.turn_context.activity.text)
      end

      def resume(dc, reason, result)
        assert_dialog_context_is_valid dc

        state = dc.active_dialog.state

        index = state[:step_index]
        run_step(dc, index+1, reason, result)
      end

      def stop(turn_ctx, instance, reason)
        assert_turn_context_is_valid turn_ctx
        assert_dialog_instance_is_valid instance
        assert_dialog_reason_is_valid reason

        if reason == DialogReason::CANCEL_CALLED
          state = instance.state.dup
          index = state[:step_index]
          step_name = waterfall_step_name(index)
          instance_id = state[:instance_id]

          logger.debug {dialog_id:@id, step_name:step_name, instance_id:instance_id}.to_json
        elsif reason == DialogReason::END_CALLED
          state = instance.state.dup
          index = state[:step_index]
          instance_id = state[:instance_id]

          logger.debug {dialog_id:@id, instance_id:instance_id}.to_json
        end

      end

      def on_step(step_ctx)
        step_name = waterfall_step_name(step_ctx.index)
        instance_id = step_ctx.active_dialog.state[:instance_id]
        return @steps[step_ctx.index][:method].call step_ctx
      end

      def run_step(dc, index, reason, result)
        assert_dialog_context_is_valid dc

        if index < @steps.count
          state = dc.active_dialog.state
          state[:step_index] = index

          options = state[:options]
          values = state[:values]
          step_context = WaterfallStepContext.new self, dc, options, values, index, reason, result

          return on_step(step_context)
        end

        return dc.end_dialog(result)
      end

      def waterfall_step_name(index)
        step_name = @steps[index][:name]

        if step_name.nil? || step_name.empty? || step_name.include?("<")
          step_name = "Step#{index+1}of#{@steps.count}"
        end

        step_name
      end

    end
  end
end