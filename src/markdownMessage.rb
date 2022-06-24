#decorator
require 'kramdown'
class MarkdownMessage < Message
    def initialize(message)
        @message = message
    end

    def message
        @message = Kramdown::Document.new(@message).to_html
        return @message
    end
end