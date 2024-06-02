# spec/models/coaching_program_spec.rb

require 'rails_helper'

RSpec.describe CoachingProgram, type: :model do
  fixtures :coaching_programs, :companies, :coaches, :employee_registrations, :users

  describe 'associations' do
    it 'belongs to a company' do
      expect(CoachingProgram.reflect_on_association(:company).macro).to eq :belongs_to
    end

    it 'has many employee registrations' do
      expect(CoachingProgram.reflect_on_association(:employee_registrations).macro).to eq :has_many
    end

    it 'has many users through employee registrations' do
      expect(CoachingProgram.reflect_on_association(:users).macro).to eq :has_many
      expect(CoachingProgram.reflect_on_association(:users).options[:through]).to eq(:employee_registrations)
    end

    it 'has and belongs to many coaches' do
      expect(CoachingProgram.reflect_on_association(:coaches).macro).to eq :has_and_belongs_to_many
      expect(CoachingProgram.reflect_on_association(:coaches).options[:join_table]).to eq(:coach_coaching_programs)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      coaching_program = coaching_programs(:program_one)
      expect(coaching_program).to be_valid
    end

    it 'is not valid without a name' do
      coaching_program = CoachingProgram.new(description: 'Description of Program Three', company: companies(:company_two))
      expect(coaching_program).not_to be_valid
      expect(coaching_program.errors[:name]).to include("can't be blank")
    end

    it 'is not valid without a company' do
      coaching_program = CoachingProgram.new(name: 'Test Program', description: 'Test Description')
      expect(coaching_program).not_to be_valid
      expect(coaching_program.errors[:company]).to include('must exist')
    end
  end
end
