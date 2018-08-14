require 'rails_helper'

RSpec.describe Enquiry, type: :model do
  it { should belong_to(:enquirer).with_foreign_key(:user_id).class_name('User') }

  it { should validate_presence_of(:source) }
  it { should validate_presence_of(:identifier) }
  it { should validate_inclusion_of(:source).in_array(['AMDirect', 'CarsForSale']) }

  describe 'Unique validation' do
    subject { described_class.new(identifier: SecureRandom.uuid) }
    it { should validate_uniqueness_of(:identifier).scoped_to([:user_id, :source]) }
  end
end
