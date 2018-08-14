require 'rails_helper'

describe EmailParsers do
  describe '.find_parser' do
    it 'finds the correct parser from filename' do
      expect(described_class.find_parser('amdirect-1.html')).to eq(described_class::AMDirectParser)
      expect(described_class.find_parser('carForSale-1.html')).to eq(described_class::CarsForSaleParser)
      expect do
        described_class.find_parser('amdirec1t-1.html')
      end.to raise_error(described_class::UnSupportedParserError, "Unsupported parser: 'amdirec1t'")
      expect do
        described_class.find_parser(nil)
      end.to raise_error(described_class::UnSupportedParserError, "Unsupported parser: ''")
    end
  end
end
