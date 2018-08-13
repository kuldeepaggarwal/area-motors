class User < ApplicationRecord
  has_many :enquiries, dependent: :destroy
end
