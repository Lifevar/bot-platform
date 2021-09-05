# frozen_string_literal: true

require 'singleton'

module BotPlatform
  module Storage
    class MemoryStorage
      include Singleton
      include Storageable

      attr_accessor :data, :locker

      def initialize
        @locker = Mutex::new
        @data = {}
      end

      def read(keys)
        new_hash = {}
        @locker.synchronize do
          keys.each do |key|
            if @data.key?(key)
              k = key.to_sym
              new_hash[k] = @data[k]
            end
          end
        end
        return new_hash
      end

      def write(changes)
        @locker.synchronize do
          changes.each do |change|
            @data[change.key.to_sym] = change.value
          end
        end
      end

      def getState(context)
        user_id = context.from[:user_id]
        room_id = context.from[:room_id] || ""
        # FIXME: room_id appear and disappear
        #key = "#{user_id}@#{room_id}"
        key = "#{user_id}".intern
        @data[key] = ConversationState.new(key) if @data[key].nil?
        return @data[key]
      end
    end

  end
end
