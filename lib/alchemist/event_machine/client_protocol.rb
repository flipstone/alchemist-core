module Alchemist
  module EventMachine
    module ClientProtocol
      # Clients should implement the various handle_* methods to
      # take action in response to serve updates
      #
      def handle_welcome;end
      def handle_hello;end
      def handle_appeared;end
      def handle_see(message);end
      def handle_inventory(message);end
      def handle_basics(message);end
      def handle_compounds(message);end
      def handle_messages(message);end
      def handel_avatars(message);end
      def handel_location(message);end
      def handle_error(message);end
      def handle_element(message);end
      def handle_noelement(message);end

      # Clients can call these methods to send commands to the server
      #
      def login(name)
        send_data name
        send_data "\n"
      end

      def appear
        send_data "appear\n"
      end

      def request_location
        send_data "location\n"
      end

      def look
        send_data "look\n"
      end

      def read
        send_data "read\n"
      end

      def request_inventory
        send_data "inventory\n"
      end

      def request_basics
        send_data "basics\n"
      end

      def request_compounds
        send_data "compounds\n"
      end

      def who
        send_data "who\n"
      end

      def move(direction)
        send_data direction
        send_data "\n"
      end

      def north
        move 'north'
      end

      def south
        move 'south'
      end

      def east
        move 'east'
      end

      def west
        move 'west'
      end

      def put(element)
        send_data "put #{element}\n"
      end

      def create(element)
        send_data "create #{element}\n"
      end

      def element(symbol, name)
        send_data "element #{symbol} #{name}\n"
      end

      def describe(symbol)
        send_data "describe #{symbol}\n"
      end

      def forge(ingred_1, ingred_2, result)
        send_data "forge #{ingred_1} #{ingred_2} #{result}\n"
      end

      def formulate(ingred_1, ingred_2, result, name)
        send_data "formulate #{ingred_1} #{ingred_2} #{result} #{name}\n"
      end

      def message(number, string)
        send_data "message #{name} #{string}"
      end

      def take
        send_data "take\n"
      end

      def receive_data(data)
        @buffer ||= ''
        @buffer << data

        while @buffer =~ /^.*?\n/
          line = $&
          receive_line line
          @buffer[0,line.length] = ''
        end
      end

      # Command framing and dispatch
      #
      def receive_line(line)
        if @lines_to_read
          @response << line
          @lines_to_read -= 1

          if @lines_to_read <= 0
            @lines_to_read = nil
            dispatch_command @command, @response
            @command = nil
            @response = nil
          end
        elsif line =~ /^(see|messages|avatars) (\d+)$/
          @command = $1
          @lines_to_read = $2.to_i
          @response = ''
        else
          dispatch_command *line.split(' ',2)
        end
      end

      def dispatch_command(command, data = nil)
        case command
        when "Welcome" then handle_welcome
        when "hello" then handle_hello
        when "appeared" then handle_appeared
        when "see" then handle_see data
        when "inventory" then handle_inventory data
        when "basics" then handle_basics data
        when "compounds" then handle_compounds data
        when "error" then handle_error data
        when "messages" then handle_messages data
        when "avatars" then handle_avatars data
        when "location" then handle_location data
        when "element" then handle_element data
        when "noelement" then handle_noelement data
        end
      end
    end
  end
end

