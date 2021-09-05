# frozen_string_literal: true

module BotPlatform
  class Boot
    def self.set_env
      puts "Set bot environment"
      # initialize channels
      BotPlatform::Adapter.instance

    end
  end
end
