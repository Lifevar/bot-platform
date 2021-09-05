# frozen_string_literal: true

module BotPlatform::Channels
  class Lineworks
    include Base

    def initialize
      @queue = []
      @api_uri = URI.parse("https://apis.worksmobile.com/r/#{ENV['LINE_API_ID']}/message/v1/bot/#{ENV['BOT_NO']}/message/push")
      @headers = {
        "Content-type": "application/json",
        "consumerKey": ENV['LINE_SERVER_CONSUMER_KEY'],
        "Authorization": ENV['LINE_SERVER_TOKEN']
      }
    end

    def channel_id
      "lineworks"
    end

    def parse_incoming_to_activity(headers, body)
      puts "Headers: #{headers.inspect}"
      puts "body: #{body.inspect}"
      user_id = body["source"]["accountId"] || ""
      room_id = body["source"]["roomId"] || ""
      activity = nil
      if cmd = as_command(headers, body)
        activity = ChatBot::Activity.new ::ChatBot::Activity::TYPES[:command], {from: {user_id: user_id, room_id: room_id}, text: cmd, channel_id: channel_id}
      elsif body["type"] == "message" && body["content"]["type"] == "image"
        activity = ChatBot::Activity.new ::ChatBot::Activity::TYPES[:image], {from: {user_id: user_id, room_id: room_id}, resource_id: body["content"]["resourceId"], channel_id: channel_id}
      else
        activity = ChatBot::Activity.new ::ChatBot::Activity::TYPES[:message], {from: {user_id: user_id, room_id: room_id}, text: body["content"]["text"], channel_id: channel_id}
      end
      puts "parse_incoming_to_activity activity:#{activity.to_json}"
      
      return activity
    end

    def send_activity(activity)
      http = Net::HTTP.new(@api_uri.host, @api_uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      content = {}
      if !activity.to[:room_id].blank?
        content["roomId"] = activity.to[:room_id]
      else
        content["accountId"] = activity.to[:user_id]
      end
      case activity.type
      when ChatBot::Activity::TYPES[:message] then
        content["content"] = {
              "type": "text",
              "text": activity.text
        }
      when ChatBot::Activity::TYPES[:image] then
        content["content"] = {
              "type": "image",
              "previewUrl": activity.preview_url,
              "resourceUrl": activity.resource_url,
        }
      when ChatBot::Activity::TYPES[:confirm] then
        content["content"] = {
          "type": "button_template",
          "contentText": activity.text,
          "actions": [
            { "type":"message", "label": "はい", "postback": "#{activity.prefix}-yes"}, 
            { "type":"message", "label": "いいえ","postback":"#{activity.prefix}-no"}
          ]
        }
      when ChatBot::Activity::TYPES[:options] then
        content["content"] = {
          "type": "button_template",
          "contentText": activity.text,
          "actions": activity.options.map{|opt| {"type":"message", "label":opt, "postback": "#{activity.prefix}-opt-#{opt}"}}
        }
      when ChatBot::Activity::TYPES[:carousel] then
        content["content"] = activity.content
      else
      end

      http.start do
        req = Net::HTTP::Post.new(@api_uri.path)
        req.initialize_http_header(@headers)
        req.body = content.to_json
        http.request(req)
      end
    end

    def match_request(headers, body)
      return !headers["X-Works-Signature"].blank?
    end

    private

    def as_command(headers, body)
      return body["data"] if body["type"] == "postback"
      return body["content"]["postback"] if body["type"] == "message" && !body["content"]["postback"].blank?
      return false
    end
  end
end