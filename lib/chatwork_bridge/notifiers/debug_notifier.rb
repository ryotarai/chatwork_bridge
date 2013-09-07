require 'chatwork_bridge'

module ChatworkBridge
  module Notifiers
    class DebugNotifier
      def notify(notification)
        $logger.debug notification
      end
    end
  end
end

