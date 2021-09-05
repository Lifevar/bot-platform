# frozen_string_literal: true

module BotPlatform::Channels
  class Teams
    include Base

    def channel_id
      "teams"
    end

    def match_request(headers,body)
      false
    end
  end
end