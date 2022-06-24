require "./src/smtp_connector"
require "./src/recipientsVisitor"

require "./src/message"
require "./src/sysinfoMessage"
require "./src/markdownMessage"

config = {
  'recipients_filename' => 'recipients.txt',
  'recipients_dbconnection' => nil
}

from = "pascal.hurni@cpnv.ch"

recipientVisitor = RecipientsVisitor.new(config)
recipients = recipientVisitor.visit

message = Message.new(ARGV.shift).message

mail_message = <<END_OF_MESSAGE
From: #{from}
To: #{recipients.join(", ")}
MIME-Version: 1.0
Content-type: text/html
Subject: Notification

#{message}
END_OF_MESSAGE

SmtpConnector.new(mail_message: mail_message, from: from, recipients: recipients).run
