module EmailParsers
  class AMDirectParser
    include Parser

    def enquirer
      @enquirer ||= Enquirer.new(user_name, user_email, enquiry)
    end

    def vehicle
      @vehicle ||= Vehicle.new(vehicle_make,
                               vehicle_model,
                               vehicle_colour,
                               vehicle_manufacturing_year)
    end

    def source
      'AMDirect'
    end

    private

      [:make, :model, :colour].each do |vehicle_method_suffix|
        # vehicle_model, vehicle_colour
        # def vehicle_make
        #   find_text(".vehicle-details #make")
        # end
        #
        define_method("vehicle_#{vehicle_method_suffix}") do
          find_text(".vehicle-details ##{vehicle_method_suffix}")
        end
      end

      def vehicle_manufacturing_year
        find_text('.vehicle-details #year')
      end

      [:name, :email].each do |user_method_suffix|
        # user_email
        # def user_name
        #   find_text('.customer-details #name')
        # end
        #
        define_method("user_#{user_method_suffix}") do
          find_text(".customer-details ##{user_method_suffix}")
        end
      end

      def enquiry
        elements = html_doc.at_css('.customer-details')
                           .children
                           .to_a
                           .split { |a| a.text == 'Enquiry:' }
                           .last

        Array(elements).map { |el| el.name == 'br' ? "\n" : el.text.remove('  ') }.join
      end

      def find_text(css)
        (html_doc.css(css) || EMPTY_ELEMENT).text
      end
  end
end
