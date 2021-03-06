require 'chatwork_bridge'
require 'selenium-webdriver'

module ChatworkBridge
  class Watcher
    attr_accessor :notifiers

    def initialize(opts={})
      opts = {interval: 1, browser: :phantomjs}.merge(opts)
      @interval = opts.fetch(:interval)
      @browser = opts.fetch(:browser)
      @chatwork_login_url = opts.fetch(:chatwork_login_url)
      @chatwork_email = opts.fetch(:chatwork_email)
      @chatwork_password = opts.fetch(:chatwork_password)
      @notifiers = opts[:notifiers] || []
    end

    def run
      begin
        init_driver
        login
        inject_code
        loop do
          if Time.now - @last_login_time > 60 * 60 * 6
            # 6 hours
            login
          end
          notification = fetch_latest_notification
          unless notification.nil?
            process_notification(notification)
          end
          sleep @interval
        end
      ensure
        quit_driver
      end
    end

    private
    def init_driver
      $logger.info "Creating selenium webdriver..."
      @driver = Selenium::WebDriver.for @browser
      $logger.info "Done."
    end

    def quit_driver
      @driver.quit
    end

    def fetch_latest_notification
      @driver.execute_script("return NotificationLogs.shift();")
    end

    def login
      $logger.info "Logging in..."
      @driver.navigate.to @chatwork_login_url
      @driver.find_element(:css, '#login_email').send_keys(@chatwork_email)
      @driver.find_element(:css, 'input[name=password]').send_keys(@chatwork_password)
      @driver.find_element(:css, 'input[name=login]').click
      $logger.info "Done."
      @last_login_time = Time.now
    end

    def inject_code
      $logger.info "Injecting code..."
      @driver.execute_script(<<-EOC)
        NotificationLogs = [];
        CW.enable_popup = true;
        CW.view.popup = function(a, b, c, d) {
          NotificationLogs.push({icon: a, room_id: d, room_name: b, content: c});
        };
      EOC
      $logger.info "Done."
    end

    def process_notification(notification)
      @notifiers.each do |notifier|
        notifier.notify(notification)
      end
    end
  end
end
