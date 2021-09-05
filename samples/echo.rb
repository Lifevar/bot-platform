class Echo
  def on_turn(ctx)
    ctx.send_message "You said: #{ctx.activity.text}"
  end
end
