require "./src/smtp_connector"
require 'kramdown'

config = {
  'recipients_filename' => 'recipients.txt',
  'recipients_dbconnection' => nil
}

from = "pascal.hurni@cpnv.ch"

recipients = []

if config['recipients_filename']
  recipients.concat(File.readlines(config['recipients_filename'], chomp: true))
end

if config['recipients_dbconnection']
  require "sqlite3"
  db = SQLite3::Database.new "users.db"
  db.execute("SELECT email FROM users") do |row|
    recipients << row['email']
  end
end


add_sysinfo = ARGV.delete('--add-sysinfo')
markdownize = ARGV.delete('--markdownize')

message = ARGV.shift
#decorator
if add_sysinfo
  message += "\n\n---\n\n"
  message += " - RUBY_VERSION: #{RUBY_VERSION}\n"
end

if markdownize
  message = Kramdown::Document.new(message).to_html
end

#decorator
mail_message = <<END_OF_MESSAGE
From: #{from}
To: #{recipients.join(", ")}
MIME-Version: 1.0
Content-type: text/html
Subject: Notification

#{message}
END_OF_MESSAGE

SmtpConnector.new(mail_message: mail_message, from: from, recipients: recipients).run
