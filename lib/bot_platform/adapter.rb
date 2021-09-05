# frozen_string_literal: true

require 'singleton'
require_relative 'asserts'
module BotPlatform
  class Adapter
    include Asserts
    include Singleton
    

    attr_reader :channels, :channel_map

    def initialize
      @channels = []
      @channel_map = {}
      channels = ENV['BOT_CHANNELS']
      raise 'No BOT_CHANNELS found in environment variables.' if channels.nil? || channels.length == 0
      channels.split(',').each do |ch|
        channel = Object.const_get("BotPlatform").const_get("Channels").const_get(ch.capitalize).new
        @channels << channel
        @channel_map[ch] = channel
      end

    end

    def send_activities(turn_context, activities)
      assert_context_is_not_null turn_context
      assert_activity_is_not_null activities
      assert_activity_is_not_null activities[0]

      activities.each do |activity|
        @channel_map[turn_context.channel_id].send_activity(activity)
      end
    end

    def update_activity(turn_context, activity, cancel_token)

    end

    def delete_activity(turn_context, conversation, cancel_token)
    end

    def continue_conversation(bot_id, bot_cb_handler)
    end

    def create_conversation(bot_id, channel_id, service_url, audience, bot_callback_handler, cancel_token)
    end

    def process_activity_async(claims_identity, activity, bot_callback_handler, cancel_token)
    end

    def process_activity(headers, body, &block)
      channel = nil
      raise 'No channel registered.' if @channels.nil? || @channels.length==0
      @channels.each do |ch|
        if ch.match_request(headers, body)
          channel = ch
          break
        end
        
      end
      raise 'No channel found' if channel.nil?

      activity = channel.parse_incoming_to_activity(headers, body)

      context = BotPlatform::TurnContext.new self, activity
      block.call(context)
    end

    def run_pipeline_async(turn_context, callback, cancel_token)
      assert_context_is_not_null(turn_context)

      if turn_context.activity != nil
        # set locale
        # run middleware
        # rescue custom onTurnError
      else
        unless callback.nil?
          # proactive
          callback(turn_context, cancel_token)
        end
      end
    end


  end
end
