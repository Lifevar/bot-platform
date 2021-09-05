# frozen_string_literal: true

module BotPlatform
  class TurnContext
    include Asserts

    attr_reader :adpter, #元のアダプター情報
      :activity, # ユーザーからの要求(incoming)
      :channel_id,
      :from

    attr_accessor :state, #コンテキストに登録されたサービスを保持
      :responded, # 応答済フラグ
      :locale,
      :buffered_reply_activities,
      :turn_state, # コンテキストに登録されたサービスを保持
      :_on_send_activities,
      :_on_update_activities,
      :_on_delete_activities

    def initialize(adapter, activity)
      @adapter = adapter
      @activity = activity # incoming activity
      @from = activity.from
      @channel_id = activity.channel_id
      @responded = false
      @locale = "ja"
      @_on_send_activities = []
      @_on_update_activities = []
      @_on_delete_activities = []

    end

    def add_on_send_activities(activity_handler)
      @_on_send_activities << activity_handler
      self
    end

    def add_on_update_activities(activity_handler)
      @_on_update_activities << activity_handler
      self
    end

    def add_on_delete_activits(activity_handler)
      @_on_delete_activities << activity_handler
      self
    end

    def self.dup_context(context, activity)
      ctx = TurnContext.new context.adapter, activity
      ctx.state = context.state
      ctx.responded = context.responded
      if context.is_a?(TurnContext)
        ctx.buffered_reply_activities = context.buffered_reply_activities
        # keep private middleware pipeline hooks.
        ctx._on_send_activities = context._on_send_activities
        ctx._on_update_activity = context._on_update_activity
        ctx._on_delete_activity = context._on_delete_activity
      end
      return ctx
    end

    def send_message(text)
      activity_to_send = Activity.new(Activity::TYPES[:message], {text: text})
      send_activity(activity_to_send)
    end

    def send_confirm(text,prefix="")
      activity_to_send = Activity.new(Activity::TYPES[:confirm], {text: text, prefix: prefix})
      send_activity(activity_to_send)
    end

    def send_options(caption, prefix, options)
      activity_to_send = Activity.new(Activity::TYPES[:options], {text: caption, options: options, prefix: prefix})
      send_activity(activity_to_send)
    end

    def send_image(preview_url, resource_url)
      activity_to_send = Activity.new(Activity::TYPES[:image], {resource_url: resource_url, preview_url: preview_url})
      send_activity(activity_to_send)
    end

    def send_content(content)
      activity_to_send = Activity.new(Activity::TYPES[:carousel], {
        content: content, to: @activity.from
      })
      send_activity(activity_to_send)
    end

    def send_activity(activity)
      activity.to = @activity.from
      send_activities([activity])
    end

    # Sends a set of activities to the sender of the incoming activity.
    def send_activities(activities)
      assert_activity_is_not_null activities
      assert_activity_is_not_null activities[0]

      @adapter.send_activities(self, activities)
    end


  end
end
