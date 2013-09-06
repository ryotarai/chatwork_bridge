require 'chatwork_bridge'
require 'thor'

module ChatworkBridge
  class CLI < Thor
    class_option :config, type: :string, required: true

    desc 'watch', 'Start watching chatwork'
    def watch
      settings = load_settings
      watcher = Watcher.new({
        chatwork_login_url: settings.chatwork_login_url,
        chatwork_email: settings.chatwork_email,
        chatwork_password: settings.chatwork_password,
      })
      watcher.notifiers = settings.notifiers
      watcher.run
    end

    private
    def load_settings
      Settings.new.tap do |s|
        s.instance_eval File.read(options[:config])
      end
    end
  end
end

