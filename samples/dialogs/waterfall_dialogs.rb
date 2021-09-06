require_relative 'waterfall_steps'
class WaterfallDialogs
  include Waterfall::Steps

  attr_accessor :dialogs

  def initialize
    storage = BotPlatform::Storage::MemoryStorage.instance
    @user_state = BotPlatform::State::UserState.new storage
    profile = @user_state.create_property("user_profile")
    @dialogs = BotPlatform::Dialogs::DialogSet.new
    steps = [
      {name:'request-name', method:->(ctx) { request_name_step(ctx) }},
      {name: 'confirm_asking_age_step', method:->(ctx) { confirm_asking_age_step(ctx, profile) }},
      {name: 'request_age_step', method:->(ctx) { request_age_step(ctx) }},
      {name: 'confirm_register_step', method: ->(ctx) { confirm_register_step(ctx, profile) }},
      {name: 'summary', method: ->(ctx) { summary_step(ctx) }},
    ]
    @dialogs.add BotPlatform::Dialogs::WaterfallDialog.new("profile", steps)
    @dialogs.add BotPlatform::Dialogs::Prompts::TextPrompt.new("name")
    @dialogs.add BotPlatform::Dialogs::Prompts::NumberPrompt.new("age")
    @dialogs.add BotPlatform::Dialogs::Prompts::ConfirmPrompt.new("confirm")

    @conversation_state = BotPlatform::State::ConversationState.new storage
  end

  def on_turn(ctx)
    if ctx.activity.type == BotPlatform::Activity::TYPES[:message]
      dialog_ctx = @dialogs.create_dialog_context(ctx)
      
      # run continue is there're some existed dialogs
      results = dialog_ctx.continue_dialog

      # there's no existed dialog
      if results.status == :empty
        dialog_ctx.start_dialog "profile", nil
      elsif results.status == :complete
        user_profile = @user_state.get_property(:user_profile)
      end

      # save user_profile and dialog_state
      @user_state.save_changes(ctx, false)
      @conversation_state.save_changes(ctx, false)
    end
  end
end
