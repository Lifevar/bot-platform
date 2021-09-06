# frozen_string_literal: true

module BotPlatform
  module Dialogs
    class WaterfallStepContext < DialogContext
      attr_reader :parent_waterfall_dialog, :index, :options,:result, :reason, :values
      attr_accessor :next_called

      def initialize(parent, dc, options, values, index, reason, result)
        super(dc.dialogs, dc.turn_context, DialogState.new(dc.dialog_stack))
        @parent_waterfall_dialog = parent
        @next_called = false
        @options = options
        @index = index
        @reason = reason
        @result = result
        @values = values
      end

      def next(result=nil)
        raise "cannot use next() twice." if @next_called

        @next_called = true
        return @parent_waterfall_dialog.resume(self, DialogReason::NEXT_CALLED, result)
      end

    end
  end
end