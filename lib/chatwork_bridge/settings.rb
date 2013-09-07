require 'chatwork_bridge'

module ChatworkBridge
  class Settings
    attr_reader :notifiers
    attr_accessor :chatwork_login_url, :chatwork_email, :chatwork_password

    def initialize
      @notifiers = []
    end

    def notifier(type, &block)
      clazz = Notifiers.const_get("#{type.to_s.capitalize}Notifier")
      notifier = clazz.new
      notifier.instance_eval(&block)
      @notifiers << notifier
    end

    def log_device=(device)
      $logger = Logger.new(device)
    end

    def log_level=(level)
      $logger.level = level
    end
  end
end

