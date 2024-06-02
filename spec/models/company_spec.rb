# spec/models/company_spec.rb

require 'rails_helper'

RSpec.describe Company, type: :model do
  fixtures :companies, :coaching_programs, :users

  describe 'associations' do
    it 'has many coaching programs' do
      expect(Company.reflect_on_association(:coaching_programs).macro).to eq :has_many
    end

    it 'has many users' do
      expect(Company.reflect_on_association(:users).macro).to eq :has_many
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      company = companies(:company_one)
      expect(company).to be_valid
    end

    it 'is not valid without a name' do
      company = Company.new
      expect(company).not_to be_valid
      expect(company.errors[:name]).to include("can't be blank")
    end
  end
end
