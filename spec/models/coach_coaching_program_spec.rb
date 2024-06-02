# spec/models/coach_coaching_program_spec.rb

require 'rails_helper'

RSpec.describe CoachCoachingProgram, type: :model do
  fixtures :coaches, :coaching_programs, :coach_coaching_programs

  describe 'associations' do
    it 'belongs to a coach' do
      expect(CoachCoachingProgram.reflect_on_association(:coach).macro).to eq :belongs_to
    end

    it 'belongs to a coaching program' do
      expect(CoachCoachingProgram.reflect_on_association(:coaching_program).macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      coach_coaching_program = coach_coaching_programs(:coach_coaching_program_one)
      expect(coach_coaching_program).to be_valid
    end
  end
end
