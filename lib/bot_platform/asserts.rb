# frozen_string_literal: true

module BotPlatform
  module Asserts
    def assert_is_not_empty(param)
      raise "#{param.name} is empty" if param.nil?
    end

    def assert_dialog_id_is_valid(dialog_id)
      raise "dialog_id is not valid" unless (dialog_id.is_a? String) && !dialog_id.empty?
    end

    def assert_dialog_context_is_valid(ctx)
      raise "dialog context is not valid" unless !ctx.nil? && (ctx.is_a? BotPlatform::Dialogs::DialogContext)
    end

    def assert_prompt_options_is_valid(options)
      raise "prompt options is not valid" unless !options.nil? && (options.is_a? BotPlatform::Dialogs::Prompts::PromptOptions)
    end

    def assert_dialog_set_is_valid(dialogs)
      raise "dialogs is not valid" if dialogs.nil? || !(dialogs.is_a? Dialogs::DialogSet)
    end

    def assert_dialog_state_is_valid(state)
      raise "dialog state is not valid" if state.nil? || !(state.is_a? Dialogs::DialogState)
    end

    def assert_dialog_is_valid(dialog)
      raise "dialog is not valid" if dialog.nil? || !(dialog.is_a? Dialogs::Dialog)
    end

    def assert_dialog_is_uniq(hash, id)
      raise "dialog is aready added" if !hash[id.to_sym].nil?
    end

    def assert_waterfall_step_context_is_valid(ctx)
      raise "Waterfall Step Context is not valid" if ctx.nil? || !(ctx.is_a? Dialogs::WaterfallStepContext)
    end

    def assert_activity_is_not_null(activity)
      raise "activity cannot be null" if activity.nil?
    end

    def assert_activity_type_is_not_null(type)
      raise "activity type cannot be null" if type.nil?
    end

    def assert_turn_context_is_valid(turn_context)
      raise "turn context is not valid" if turn_context.nil? || !(turn_context.is_a? TurnContext)
    end

    def assert_context_is_not_null(turn_context)
      raise "turn context cannot be null" if turn_context.nil?
    end

    def assert_conversation_reference_is_not_null(conversation_ref)
      raise "conversation reference cannot be null" if conversation_ref.nil?
    end

    def assert_activity_list_is_not_null(activities)
      raise "activity list cannot be null" if activities.nil?
    end

    def assert_middleware_is_not_null(middleware)
      raise "middleware cannot be null" if middleware.nil?
    end

    def assert_middleware_list_is_not_null(middlewares)
      raise "middleware list cannot be null" if middlewares.nil?
    end
  end
end
