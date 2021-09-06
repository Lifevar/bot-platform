# frozen_string_literal: true

module BotPlatform
  module Dialogs
    # a delegate class
    class WaterfallStep

      def initialize(&step)
        @step = step
      end

      def do_step(step_ctx)
        @step.call step_ctx
      end
    end
  end
end