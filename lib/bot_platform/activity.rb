# frozen_string_literal: true

module BotPlatform
  class Activity
    attr_reader :type, :text, :content, :options, :from, :prefix, :preview_url, :resource_id, :resource_url, :channel_id
    attr_accessor :to
      TYPES = {
      typing: 1, 
      message: 2,
      image: 3,
      confirm: 4,
      options: 5,
      carousel: 6,
      command: 7,
      card: 9 
    }.freeze

    def initialize(type, opts={})
      @type = type
      @resource_id = opts[:resource_id]
      @content = opts[:content]
      @options = opts[:options]
      @prefix = opts[:prefix]
      @text = opts[:text]
      @preview_url = opts[:preview_url]
      @resource_url = opts[:resource_url]
      @from = opts[:from]
      @to = opts[:to]
      @channel_id = opts[:channel_id]
    end
  end
end
