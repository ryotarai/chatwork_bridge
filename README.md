# ChatworkBridge

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'chatwork_bridge'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chatwork_bridge

## Usage

Config:
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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
