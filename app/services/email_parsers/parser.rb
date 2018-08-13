module EmailParsers
  module Parser
    extend ActiveSupport::Concern

    Enquirer = Struct.new(:name, :email)
    Vehicle = Struct.new(:make, :model, :color, :year)
    EMPTY_ELEMENT = Nokogiri::XML.fragment('<span></span>')

    class_methods do
      def parse(html_content)
        new(html_content).parse
      end
    end

    attr_reader :html_content
    def initialize(html_content)
      @html_content = html_content
    end

    def html_doc
      @html_doc ||= Nokogiri::HTML(html_content)
    end

    def parse
      {
        name: enquirer.name,
        email: enquirer.email,
        enquiry: enquiry,
        vehicle_attributes: {
          make: vehicle.make,
          model: vehicle.model,
          color: vehicle.color,
          year: vehicle.year
        },
        source: source
      }
    end

    def enquirer
      raise NotImplementedError
    end

    def vehicle
      raise NotImplementedError
    end

    def source
      raise NotImplementedError
    end

    def enquiry
      raise NotImplementedError
    end

    def empty_element
      EMPTY_ELEMENT
    end
  end
end
