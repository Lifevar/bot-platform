class DialogSimple
  attr_accessor :dialogs

  def initialize
    @dialogs = BotPlatform::Dialogs::DialogSet.new
    @dialogs.add(BotPlatform::Dialogs::Prompts::TextPrompt.new("name"))

    storage = BotPlatform::Storage::MemoryStorage.instance
    @conversation_state = BotPlatform::State::ConversationState.new storage
  end

  def on_turn(ctx)
    dialog_ctx = @dialogs.create_dialog_context(ctx)
    results = dialog_ctx.continue_dialog

    if results.status == :empty
      dialog_ctx.prompt(
        "name",
        BotPlatform::Dialogs::Prompts::PromptOptions.new(
          prompt: BotPlatform::MessageFactory.Text("Input your name please:")
        )
      )
    elsif results.status == :complete
      unless results.result.nil?
        ctx.send_activity BotPlatform::MessageFactory.Text("Hello! #{results.result}!")
      end
    end
    @conversation_state.save_changes(ctx, false)
  end
end
