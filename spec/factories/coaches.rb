# spec/factories/coaches.rb
FactoryBot.define do
  factory :coach do
    user { create(:user, role: 'coach') }
  end
end
