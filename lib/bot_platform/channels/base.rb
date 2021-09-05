# frozen_string_literal: true

module BotPlatform
  module Channels
    module Base
      class NeedImplementation < StandardError; end

      def channel_id
        raise NeedImplementation
      end

      def send_activity(activity)
        raise NeedImplementation
      end

      def as_command(activity)
        raise NeedImplementation
      end

      def match_request(headers,body)
        raise NeedImplementation
      end

    end
  end
end
