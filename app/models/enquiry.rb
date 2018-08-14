class Enquiry < ApplicationRecord
  belongs_to :enquirer, foreign_key: :user_id, class_name: 'User'

  delegate :id, :name, :email, to: :enquirer, prefix: true

  validates :source, :identifier, presence: true
  validates :source, inclusion: { in: ['AMDirect', 'CarsForSale'] }, allow_blank: true
  validates :identifier, uniqueness: { scope: [:user_id, :source] }, allow_blank: true
end
