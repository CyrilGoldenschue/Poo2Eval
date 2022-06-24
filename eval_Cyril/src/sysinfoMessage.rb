
class SysinfoMessage < Message
    def initialize(message)
        @message = message
    end

    def message
        @message += "\n\n---\n\n"
        @message += " - RUBY_VERSION: #{RUBY_VERSION}\n"
        return @message
    end
end