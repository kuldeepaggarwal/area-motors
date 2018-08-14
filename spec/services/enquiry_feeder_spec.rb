require 'rails_helper'

describe EnquiryFeeder do
  let(:folder) { Rails.root.join('spec/fixtures/email_templates/am_direct') }
  subject { described_class.new(folder) }

  describe '#enquiries' do
    it 'returns parsed enquiries' do
      expect(subject.enquiries.to_a).to eq([
        {
          name: 'John Smith',
          email: 'johnsmith@mailinator.com',
          enquiry: "\n\nI'm interested in buying this car.\nWould you take part exchange?\nThanks,\n\nJohn\n",
          vehicle_attributes: {
            make: 'Ford',
            model: 'Focus',
            color: 'blue',
            year: '2008'
          },
          source: 'AMDirect',
          identifier: 'amdirect-1.html'
        },
        {
          name: 'Sarah-Jane Hardigan',
          email: 'sjhardigan@mailinator.com',
          enquiry: "\nIs this vehicle still available?\n",
          vehicle_attributes: {
            make: 'Lotus',
            model: 'Elise',
            color: 'green',
            year: '1999'
          },
          source: 'AMDirect',
          identifier: 'amdirect-2.html'
        }
      ])
    end
  end
end
