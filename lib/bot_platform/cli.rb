# frozen_string_literal: true

require 'json'
require 'readline'
require 'getoptlong'
require 'singleton'

module BotPlatform
  class Cli
    attr_accessor :bot_name, :user_name, :bot_id, :room_id, :bot_instance

    def initialize(instance)
      @bot_name = "bot"
      @user_name = "user"
      @bot_instance = instance
      ENV['BOT_CHANNELS'] = 'console'
      
      Signal.trap(:INT) do
        puts "\nbye."
        exit 0
      end
    end

    def run
      puts welcome_message

      opts = GetoptLong.new(
        ['--name', GetoptLong::OPTIONAL_ARGUMENT]
      )
      opts.each do |opt, arg|
        case opt
        when '--name' then @bot_name = arg
        end
      end

      while cmd = Readline.readline(prompt, true)
        case cmd
        when "exit", "quit", '\q' then
          exit
        when "help", '\h', '\?' then
          puts help
        when 'clear', '\c' then
          system 'clear'
        else # bot incoming activity
          unless cmd.empty?
            process cmd
          end
        end
      end
    end

    def process(cmd)
      headers = {"X-Bot-Platform-Bot":@bot_name}
      body = {bot_id:@bot_id, room_id:@room_id}
      if cmd.start_with? '/'
        body[:type] = "cmd_back"
        cmd.slice!(0)
        body[:cmd] = cmd
      else
        body[:type] = "message"
        body[:text] = cmd
      end

      instance = @bot_instance

      BotPlatform::Adapter.instance.process_activity headers,body do |context|
        instance.on_turn context
      end

    end

    def prompt
      return "#{@user_name}> "
    end

    def help
      <<-USAGE
usage:
history
exit, quit, \\q - close shell and exit
help, \\h, \\? - print this usage
clear, \\c - clear the terminal screen
      USAGE
    end

    def welcome_message
      <<-WELCOME
Welcome to Bot Platform Command Line Interface (v0.1)
       \\------/
    _ [| o ω o|] _
   / |==\\__-__/=| \\

   powered by Ningfeng Yang
         WELCOME
    end
  end
end
