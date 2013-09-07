# ChatworkBridge

Send ChatWork notifications via email, stdout or etc...

## Installation

    $ gem install chatwork_bridge

## Usage

Put a config file named `~/.chatwork_bridge.config.rb`:
```ruby
self.chatwork_login_url = 'https://www.chatwork.com/login.php'
self.chatwork_email = ''
self.chatwork_password = ''

notifier :debug do
end

notifier :email do
  self.to = ''
  self.from = ''
  self.smtp_host = 'smtp.gmail.com'
  self.smtp_port = 587
  self.smtp_user = ''
  self.smtp_password = ''
  self.enable_tls = true
end
```

Run watcher:
```
$ chatwork_bridge watch
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
