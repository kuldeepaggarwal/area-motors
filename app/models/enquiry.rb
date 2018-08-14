class Enquiry < ApplicationRecord
  belongs_to :enquirer, foreign_key: :user_id, class_name: 'User'

  delegate :id, :name, :email, to: :enquirer, prefix: true

  validates :source, :identifier, presence: true
  validates :source, inclusion: { in: ['AMDirect', 'CarsForSale'] }, allow_blank: true
  validates :identifier, uniqueness: { scope: [:user_id, :source] }, allow_blank: true

  concerning :Transitions do
    included do
      include ::AASM

      aasm whiny_transitions: false do
        state :pending, initial: true
        state :processed, :not_valid, :duplicate

        event :open do
          transitions from: [:not_valid, :duplicate, :processed], to: :pending
        end

        event :invalidate do
          transitions from: :pending, to: :not_valid
        end

        event :finish do
          transitions from: :pending, to: :processed
        end

        event :already_processed do
          transitions from: :pending, to: :duplicate
        end
      end
    end
  end
end
