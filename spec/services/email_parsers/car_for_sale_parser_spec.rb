require 'rails_helper'

describe EmailParsers::CarForSaleParser, type: :parser do
  let(:email_content) do
    File.read(Rails.root.join('spec/fixtures/email_templates/cars_for_sale/careforsale-1.html'))
  end

  subject { described_class }

  it 'parses the html and returns the structured attributes' do
    expect(subject.parse(email_content)).to eq(
      name: 'John Smith',
      email: 'johnsmith@mailinator.com',
      enquiry: "\nDo you take part exchange?\nWhat is the warranty like?\n\n\nYou can view the vehicle here\n",
      vehicle_attributes: {
        make: 'Renault',
        model: 'Clio',
        color: 'White',
        year: '2006'
      },
      source: 'CarForSale'
    )
  end
end
