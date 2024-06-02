require 'rails_helper'

RSpec.describe Coach, type: :model do
  fixtures :coaches, :users, :employee_registrations, :coaching_programs, :coach_coaching_programs

  describe 'validations' do
    it 'is valid with valid attributes' do
      coach = coaches(:coach_one)
      expect(coach).to be_valid
    end

    it 'is not valid without a user_id' do
      coach = coaches(:invalid_coach)
      expect(coach).not_to be_valid
      expect(coach.errors[:user_id]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(Coach.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'has many employee registrations' do
      expect(Coach.reflect_on_association(:employee_registrations).macro).to eq :has_many
    end

    it 'has and belongs to many coaching programs' do
      expect(Coach.reflect_on_association(:coaching_programs).macro).to eq :has_and_belongs_to_many
    end
  end
end
