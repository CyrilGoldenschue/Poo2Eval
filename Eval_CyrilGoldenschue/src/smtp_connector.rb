# wrapper
require 'net/smtp'

class SmtpConnector
    def initialize(mail_message:, from:, recipients:)
        @mail_message = mail_message
        @from = from
        @recipients = recipients
    end

    def run
        Net::SMTP.start('mail.cpnv.ch', 25) do |smtp|
            smtp.send_message @mail_message,
            @from,
            @recipients
        end
    end
end
  