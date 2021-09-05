# frozen_string_literal: true

module BotPlatform::Channels
  class Web
    include Base

    def channel_id
      "web"
    end

    def match_request(headers,body)
      false
    end
  end
end