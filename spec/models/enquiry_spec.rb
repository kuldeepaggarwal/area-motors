require 'rails_helper'

RSpec.describe Enquiry, type: :model do
  it { should belong_to(:enquirer).with_foreign_key(:user_id).class_name('User') }
end
