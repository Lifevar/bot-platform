##
*This Project is still underconstruction.*

# Bot Platform (Ruby Version)

A ruby based Bot platform to let developers to focus on bot's business logic ONLY. You can connect your bot to channels such as slack, teams, lineworks, chatwork and etc within only a few steps of settings(without coding) to use the same bot's logic. check the [supported bot channels](https://github.com/lifevar/bot-platform/blob/main/docs/channels.md#supported).

We also provide CLI(Command Line Interface) to accelerate the testing and demo processes.

You can use DemoKit(underconstruction) to support your bot conversations to customers.


We reference Microsoft's BotFramework now(great thanking to MS), but we'll change the platform to be more different and better in the furture. The big difference between this project and BotFramework is that you need not binding the bot to Azure or sth. else specified platform.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bot_platform'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bot_platform

## Usage

    $ bin/cli samples/echo.rb


or

    $ bin/cli samples/dialogs/dialog_simple.rb

## Development

We're working on both console bot and Line Works bot nowtime. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lifevar/bot-platform. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/lifevar/bot-platform/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the BotPlatform project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lifevar/bot-platform/blob/master/CODE_OF_CONDUCT.md).
