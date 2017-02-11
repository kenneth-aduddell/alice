module Pipeline

  class Mediator

    def self.bot_name
      ENV['BOT_NAME']
    end

    def self.non_op?(channel_user)
      ! op?(channel_user)
    end

    def self.op?(nick)
      op_nicks.include?(nick.downcase)
    end

    def self.is_bot?(nick)
      bot_name == nick
    end

    def self.op_nicks
      ENV['OPS'].split(',')
    end

    def self.user_from(channel_user)
      User.from(channel_user)
    end

    def self.reply_with(text)
      text = Util::Sanitizer.process(text)
      text = Util::Sanitizer.initial_upcase(text)
      Alice::Util::Logger.info "*** replying with \"#{text}\" ***"
      text.to_s
    end

    def self.emote(message)
      text = Util::Sanitizer.process(message)
      text = Util::Sanitizer.initial_downcase(text)
      text = "_#{text}_"
      Alice::Util::Logger.info "*** emoting \"#{text}\" ***"
      text
    end

  end

end
