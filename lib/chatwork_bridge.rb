require "chatwork_bridge/version"
require "chatwork_bridge/cli"
require "chatwork_bridge/settings"
require "chatwork_bridge/watcher"
require "chatwork_bridge/notifiers"

require 'logger'
$logger = Logger.new(STDOUT)

module ChatworkBridge
end
