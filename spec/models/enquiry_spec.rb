require 'rails_helper'

RSpec.describe Enquiry, type: :model do
  it { should belong_to(:user) }
end
