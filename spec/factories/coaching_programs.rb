FactoryBot.define do
  factory :coaching_program do
    name { Faker::Educator.course_name }
    description { Faker::Lorem.paragraph }
    company
    # Add any other attributes as needed
  end
end
