module BotPlatform
  class BotAssert
    class << self
      def dialog_id_not_empty(dialog_id)
        raise "dialog_id cannot be null" if dialog_id.nil? || dialog_id.empty?
      end

      def dialog_set_is_valid(dialogs)
        raise "dialogs is not valid" if dialogs.nil? || !dialogs.is_a? Dialogs::DialogSet
      end

      def dialog_state_is_valid(state)
        raise "dialog state is not valid" if state.nil? || !state.is_a? Dialogs::DialogState
      end

      def dialog_is_valid(dialog)
        raise "dialog is not valid" if dialog.nil? || !dialog.is_a? Dialogs::Dialog
      end

      def dialog_is_uniq(hash, id)
        raise "dialog is aready added" if !hash[id.to_sym].nil?
      end

      def activity_not_null(activity)
        raise "activity cannot be null" if activity.nil?
      end

      def activity_type_not_null(type)
        raise "activity type cannot be null" if type.nil?
      end

      def turn_context_is_valid(turn_context)
        raise "turn context is not valid" if turn_context.nil? || !turn_context.is_a? TurnContext
      end

      def context_not_null(turn_context)
        raise "turn context cannot be null" if turn_context.nil?
      end

      def conversation_reference_not_null(conversation_ref)
        raise "conversation reference cannot be null" if conversation_ref.nil?
      end

      def activity_list_not_null(activities)
        raise "activity list cannot be null" if activities.nil?
      end

      def middleware_not_null(middleware)
        raise "middleware cannot be null" if middleware.nil?
      end

      def middleware_list_not_null(middlewares)
        raise "middleware list cannot be null" if middlewares.nil?
      end
    end
  end
end