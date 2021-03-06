##
*This Project is still underconstruction.*

![One Bot, Multiple Channels!](https://github.com/Lifevar/bot-platform/blob/main/images/bot-platform.png)

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

```bash
$ gem install bot_platform
```

## Usage

Documents are under-construction.

## Demos

### CLI

Clone this repository first. Go to the root directory and run:

```bash
bin/cli [bot-script]
```

echo sample:

```bash
$ bin/cli samples/echo.rb
```

simple dialog sample:

```bash
$ bin/cli samples/dialogs/dialog_simple.rb
```

waterfall dialog sample:

```bash
$ bin/cli samples/dialogs/waterfall_dialogs.rb
```

You can use 'exit' to quit bot shell. You can write your own bot scripts, be careful the file's name should be snake format.(We guess the class name from the file's name)

## Development

We're working on both console bot and Line Works bot nowtime and has plan to develop to other channels.

It's welcome to share your channel's code to us.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lifevar/bot-platform. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/lifevar/bot-platform/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the BotPlatform project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lifevar/bot-platform/blob/master/CODE_OF_CONDUCT.md).
