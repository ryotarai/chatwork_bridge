require 'chatwork_bridge'
require 'thor'

module ChatworkBridge
  class CLI < Thor
    class_option :config, type: :string

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
      config_paths = %w! ~/.chatwork_bridge.config.rb !
      config_paths.unshift(options[:config]) if options[:config]
      config_paths.map! {|path| File.expand_path(path) }
      config_path = config_paths.find {|path| File.exists?(path) }
      if config_path.nil?
        $logger.fatal "Config file is not found. (Search Paths: #{config_paths})"
        abort
      end
      Settings.new.tap do |s|
        s.instance_eval File.read(config_path)
      end
    end
  end
end

