require 'rails_helper'

describe EmailParsers::AMDirectParser, type: :parser do
  let(:email_content1) do
    File.read(Rails.root.join('spec/fixtures/email_templates/am_direct/amdirect-1.html'))
  end

  let(:email_content2) do
    File.read(Rails.root.join('spec/fixtures/email_templates/am_direct/amdirect-2.html'))
  end

  subject { described_class }

  it 'parses the html and returns the structured attributes' do
    expect(subject.parse(email_content1)).to eq(
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

  it 'parses another response too' do
    expect(subject.parse(email_content2)).to eq(
      name: 'Sarah-Jane Hardigan',
      email: 'sjhardigan@mailinator.com',
      enquiry: "\nIs this vehicle still available?\n",
      vehicle_attributes: {
        make: 'Lotus',
        model: 'Elise',
        color: 'green',
        year: '1999'
      },
      source: 'AMDirect'
    )
  end
end
