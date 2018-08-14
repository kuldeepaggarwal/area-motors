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

  describe 'states transistions' do
    it { should transition_from(:not_valid).to(:pending).on_event(:open) }
    it { should transition_from(:duplicate).to(:pending).on_event(:open) }
    it { should transition_from(:processed).to(:pending).on_event(:open) }

    it { should transition_from(:pending).to(:not_valid).on_event(:invalidate) }
    it { should_not transition_from(:processed).to(:not_valid).on_event(:invalidate) }
    it { should_not transition_from(:duplicate).to(:not_valid).on_event(:invalidate) }

    it { should transition_from(:pending).to(:processed).on_event(:finish) }
    it { should_not transition_from(:duplicate).to(:processed).on_event(:finish) }
    it { should_not transition_from(:not_valid).to(:processed).on_event(:finish) }

    it { should transition_from(:pending).to(:duplicate).on_event(:already_processed) }
    it { should_not transition_from(:not_valid).to(:duplicate).on_event(:already_processed) }
    it { should_not transition_from(:processed).to(:duplicate).on_event(:already_processed) }
  end
end
