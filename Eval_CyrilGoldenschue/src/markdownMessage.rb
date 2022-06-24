#decorator
require 'kramdown'
class MarkdownMessage < MessageHandler
    def initialize(message)
        @message = message
    end

    def message
        @message = Kramdown::Document.new(@message).to_html
        return @message
    end
end