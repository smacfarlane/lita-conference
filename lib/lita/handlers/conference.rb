module Lita
  module Handlers
    class Conference < Handler
      # insert handler code here
      config :conferences, type: Hash, default: Hash.new

      route %r{^conferences}, :conferences, command: true, help: { "conferences": "List available conference numbers" }
      route %r{^conference\s+(\w+)}, :conference, command: true, help: { "conference CONFERENCE": "Show conference information for CONFERENCE" }

      def conferences(response)
        if config.conferences.empty?
          response.reply "No conference numbers available"
        else
          response.reply "Available Conference Numbers: #{config.conferences.keys.join(", ")}"
        end
      end

      def conference(response)
        response.reply("That conference number isn't available")
      end
      Lita.register_handler(self)
    end
  end
end

# module Lita
#   module Handlers
#     class Gina < Handler
#       config :conferences
#       # insert handler code here
#       route /^conference\s+(\w+)/, :conference, help: {
#         "conference CONFERENCE_NAME" => "Show conference information for CONFERENCE_NAME"
#       }
#       def conference(response)
#         name = response.args.first
#         response.reply config.conferences
#         # conf = config.send(name)
#
#         # if conf.nil?
#         #   response.reply "Could not find conference information for #{name}"
#         # else
#         #   response.reply "NOOO"
#         # end
#       end
#
#       Lita.register_handler(self)
#     end
#   end
# end
