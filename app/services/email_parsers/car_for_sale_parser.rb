module EmailParsers
  class CarForSaleParser
    include Parser
    ALPHA_NUM_REGEXP = /[^A-z0-9]*/
    NAME_AND_EMAIL_REGEXP = /\n\s*(?<name>.*)\s*\((?<email>.*)\)/

    def vehicle
      @vehicle ||= Vehicle.new(*vehicle_details.values_at('make', 'model', 'colour', 'year'))
    end

    def enquirer
      @enquirer ||= Enquirer.new(*user_details.values_at('name', 'email'))
    end

    def source
      'CarForSale'
    end

    def enquiry
      find_line_breaker_text(enquiry_and_user_details.last)
        .remove(/He asked\:\s*/i)
        .remove('  ')
    end

    private

      def user_details
        matcher = enquiry_and_user_details.first.map(&:text).join.match(NAME_AND_EMAIL_REGEXP)
        matcher.named_captures.each { |_, v| v.squish! } if matcher
      end

      def enquiry_and_user_details
        @enquiry_and_user_details ||= \
          html_doc.at('body div').children.to_a.split { |elem| elem.name == 'table' }
      end

      def vehicle_details
        html_doc.at('table').search('tr').map do |tr|
          cells = tr.search('th, td')
          cells.map do |cell|
            cell.text.strip.remove(ALPHA_NUM_REGEXP)
          end
        end.to_h.transform_keys! { |k| k.to_s.downcase }
      end
  end
end
