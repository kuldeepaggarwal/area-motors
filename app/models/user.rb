class User < ApplicationRecord
  has_many :enquiries, dependent: :destroy

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false, allow_blank: true }
  validates :name, :email, presence: true
end
