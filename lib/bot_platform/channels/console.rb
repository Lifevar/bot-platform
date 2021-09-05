# frozen_string_literal: true

module BotPlatform::Channels
  class Console
    include BotPlatform::Channels::Base

    def channel_id
      "console"
    end

    def key
      "X-Bot-Platform-Bot".intern
    end

    def match_request(headers, body)
      return false if headers.nil?
      return !(headers[key].nil? || headers[key].empty?)
    end

    def send_activity(activity)
      case activity.type
      when BotPlatform::Activity::TYPES[:message] then
        puts "bot> #{activity.text}"
      when BotPlatform::Activity::TYPES[:carousel] then
        puts "bot> select from the list:"
        content = activity.content
        content[:columns].each_with_index do |col, idx|
          puts "#{idx+1}: #{col[:title]}(#{col[:text]}) [/#{col[:defaultAction][:data]}]"
        end
      when BotPlatform::Activity::TYPES[:options] then
        puts "bot> #{activity.text}"
        activity.options.each_with_index{|opt, idx| puts "#{idx+1}: #{opt} [/#{activity.prefix}-opt-#{idx}]"}
      when BotPlatform::Activity::TYPES[:image] then
        `open -a '/Applications/Google Chrome.app' #{activity.resource_url}`
      else
        puts "bot[debug]> activity.inspect"
      end
    end

    def parse_incoming_to_activity(headers, body)
      user_id = body[:bot_id] || ""
      room_id = body[:room_id] || ""
      activity = nil
      cmd = as_command(headers, body)
      if cmd
        activity = BotPlatform::Activity.new ::BotPlatform::Activity::TYPES[:command], {from: {user_id: user_id, room_id: room_id}, text: cmd, channel_id: channel_id}
      else
        activity = BotPlatform::Activity.new ::BotPlatform::Activity::TYPES[:message], {from: {user_id: user_id, room_id: room_id}, text: body[:text], channel_id: channel_id}
      end
      
      return activity
    end

    def as_command(headers, body)
      return body[:cmd] if body[:type] == "cmd_back"
      return false
    end

  end
end
