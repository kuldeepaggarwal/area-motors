require 'rails_helper'

describe EmailParsers::AMDirectParser, type: :parser do
  let(:email_content) do
    File.read(Rails.root.join('spec/fixtures/email_templates/am_direct/amdirect-1.html'))
  end

  subject { described_class }

  it 'parses the html and returns the structured attributes' do
    expect(subject.parse(email_content)).to eq(
      name: 'John Smith',
      email: 'johnsmith@mailinator.com',
      enquiry: "\n\nI'm interested in buying this car.\nWould you take part exchange?\nThanks,\n\nJohn\n",
      vehicle_attributes: {
        make: 'Ford',
        model: 'Focus',
        color: 'blue',
        year: '2008'
      },
      source: 'AMDirect'
    )
  end
end
