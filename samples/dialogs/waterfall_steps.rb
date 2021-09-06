module Waterfall
  module Steps
    def request_name_step(step_ctx)
      return step_ctx.prompt(
        "name", 
        BotPlatform::Dialogs::Prompts::PromptOptions.new(
          prompt:BotPlatform::MessageFactory.Text("Input your name please.")
        )
      )
    end

    def confirm_asking_age_step(step_ctx, user_profile)
      profile = user_profile
      profile[:name] = step_ctx.result
      return step_ctx.prompt(
        "confirm", 
        BotPlatform::Dialogs::Prompts::PromptOptions.new(
          prompt:BotPlatform::MessageFactory.Text("May I ask your age?")
        )
      )
    end

    def request_age_step(step_ctx)
      if step_ctx.result
        step_ctx.prompt("age", BotPlatform::Dialogs::Prompts::PromptOptions.new(prompt:BotPlatform::MessageFactory.Text("Input your age please")))
      else
        step_ctx.next(-1)
      end
    end

    def confirm_register_step(step_ctx, profile)
      age = step_ctx.result.to_i

      profile[:age] = '(unknown)'
      profile[:age] = age if age != -1

      prompt = "Register user profile as below. Is it okay?\n Name:#{profile[:name]}\n Age: #{profile[:age]}"
      step_ctx.prompt("confirm", BotPlatform::Dialogs::Prompts::PromptOptions.new(prompt:BotPlatform::MessageFactory.Text(prompt)))
    end

    def summary_step(step_ctx)
      if step_ctx.result
        step_ctx.turn_context.send_message "Profile saved."
      else
        step_ctx.turn_context.send_message "Profile registration has been canceled."
      end
      step_ctx.stop_dialog
    end
  end
end
