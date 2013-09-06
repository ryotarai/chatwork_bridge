require 'chatwork_bridge'

module ChatworkBridge
  module Notifiers
    class DebugNotifier
      def notify(notification)
        p notification
      end
    end
  end
end

