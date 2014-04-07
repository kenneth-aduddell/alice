require 'cinch'

module Alice

  module Listeners

    class Nlp

      include Cinch::Plugin

      match /(.*[ ]?alice.*)/i, method: :process, use_prefix: false

      def process(m, message)
        response = Alice::Command.parse(m.user.nick, message) 
        response && response.kind == :reply && m.reply(response.content)
        response && response.kind == :action && m.action_reply(response.content)
      end    

    end

  end

end
