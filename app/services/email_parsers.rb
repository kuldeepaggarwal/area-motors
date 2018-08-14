module EmailParsers
  UnSupportedParserError = Class.new(StandardError)

  def self.find_parser(file_name)
    parser_candidate = file_name.to_s.downcase.split('-').first
    case parser_candidate
    when 'amdirect' then self::AMDirectParser
    when 'carforsale' then self::CarsForSaleParser
    else raise(UnSupportedParserError, "Unsupported parser: '#{parser_candidate}'")
    end
  end
end
