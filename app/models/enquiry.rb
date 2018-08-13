class Enquiry < ApplicationRecord
  belongs_to :enquirer, foreign_key: :user_id, class_name: 'User'
end
