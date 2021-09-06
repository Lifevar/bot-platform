# frozen_string_literal: true

module BotPlatform
  module Dialogs
    class DialogReason
      BEGIN_CALLED    = 1
      CONTINUE_CALLED = 2
      CANCEL_CALLED   = 3
      END_CALLED      = 4
      REPLACE_CALLED  = 5
      NEXT_CALLED     = 6
    end
  end
end