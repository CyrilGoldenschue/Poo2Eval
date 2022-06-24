#factory

class MessageFactory 
    def initialize(message)
        @message = message
    end

    def message
        add_sysinfo = ARGV.delete('--add-sysinfo')
        markdownize = ARGV.delete('--markdownize')

        if add_sysinfo
            @message = SysinfoMessage.new(@message).message
          end
        
        if markdownize
          @message = MarkdownMessage.new(@message).message
        end

        return @message
    end
end