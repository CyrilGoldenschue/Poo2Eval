#visitor
class RecipientsVisitor
    def initialize(config)
        @config = config
        @recipients = []
    end

    def visit
        if @config['recipients_filename']
          return @recipients.concat(File.readlines(@config['recipients_filename'], chomp: true))
        end
        
        if @config['recipients_dbconnection']
          require "sqlite3"
          db = SQLite3::Database.new "users.db"
          db.execute("SELECT email FROM users") do |row|
            return @recipients << row['email']
          end
        end
    end
end