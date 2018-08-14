FactoryBot.define do
  factory :enquiry do
    association :enquirer, factory: :user
    sequence(:identifier) { |number| number }
    aasm_state 'pending'

    trait :am_direct do
      source 'AMDirect'
    end

    trait :cars_for_sale do
      source 'CarsForSale'
    end

    trait :processed do
      aasm_state 'processed'
    end

    trait :not_valid do
      aasm_state 'not_valid'
    end

    trait :duplicate do
      aasm_state 'duplicate'
    end
  end
end
