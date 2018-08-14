FactoryBot.define do
  factory :user do
    name 'Kuldeep Aggarwal'
    sequence(:email) { |number| "test#{number}@gmail.com" }
  end
end
