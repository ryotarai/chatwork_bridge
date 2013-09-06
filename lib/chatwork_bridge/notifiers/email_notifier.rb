require 'chatwork_bridge'
require 'net/smtp'
require 'mail'

module ChatworkBridge
  module Notifiers
    class EmailNotifier
      attr_accessor :to, :from, :smtp_host, :smtp_port, :enable_tls, :smtp_user, :smtp_password

      def notify(notification)
        send_email(
          "Re: [ChatWork] #{notification['room_name']}",
          notification['content']
        )
      end

      def send_email(subject, body)
        to_addr = self.to
        from_addr = self.from
        mail = Mail.new do
          to      to_addr
          from    from_addr
          subject subject
          body    body
        end
        mail.charset = 'utf-8'

        smtp = Net::SMTP.new(self.smtp_host, self.smtp_port)
        smtp.enable_starttls if self.enable_tls
        smtp.start(self.smtp_host, self.smtp_user, self.smtp_password, :login) do
          smtp.send_message(mail.encoded, mail.from, mail.to)
        end
      end
    end
  end
end

