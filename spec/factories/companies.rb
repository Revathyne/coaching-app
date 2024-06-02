FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    # Add any other attributes as needed
  end
end
