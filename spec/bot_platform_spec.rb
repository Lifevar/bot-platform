# frozen_string_literal: true

RSpec.describe BotPlatform do
  it "has a version number" do
    expect(BotPlatform::VERSION).not_to be nil
  end

  it "greet test" do
    expect(BotPlatform.greet).to eq("Welcome to Bot Platform")
  end
end
