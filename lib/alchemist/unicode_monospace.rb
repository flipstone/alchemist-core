module Alchemist
  module UnicodeMonospace
    module StringExtensions
      def pad_to_unicode_monospace
        unpack('U*').flat_map do |c|
          next c if c == "\n".ord

          case UnicodeMonospace.east_asian_width(c)
          when /^F|W$/ then c
          else [c, ' '.ord]
          end
        end.pack('U*')
      end
    end

    def self.east_asian_width(c)
      east_asian_widths[c]
    end

    def self.east_asian_widths
      @east_asian_widths ||= build_east_asian_widths
    end

    DATA_FILE = File.join(File.dirname(__FILE__), 'EastAsianWidth.txt')

    def self.build_east_asian_widths
      widths = {}
      File.open(DATA_FILE) do |io|
        io.each_line do |line|
          next if line =~ /^#/
          code_spec, width, _ = line.split(/;|#/)

          codes = if code_spec =~ /\.\./
                    min,max = code_spec.split '..'
                    (min.to_i(16)..max.to_i(16)).to_a
                  else
                    [code_spec.to_i(16)]
                  end

          codes.each do |code|
            widths[code] = width && width.strip
          end
        end
      end

      widths
    end
  end
end

String.class_eval do
  include Alchemist::UnicodeMonospace::StringExtensions
end
