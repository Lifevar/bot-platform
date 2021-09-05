# frozen_string_literal: true

module BotPlatform::Channels
  class Slack
    include Base

    def channel_id
      "slack"
    end

    def match_request(headers,body)
      false
    end
  end
end