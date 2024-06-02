# spec/models/employee_registration_spec.rb

require 'rails_helper'

RSpec.describe EmployeeRegistration, type: :model do
  fixtures :users, :coaching_programs, :coaches, :employee_registrations

  describe 'associations' do
    it 'belongs to user' do
      expect(EmployeeRegistration.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'belongs to coaching_program' do
      expect(EmployeeRegistration.reflect_on_association(:coaching_program).macro).to eq :belongs_to
    end

    it 'belongs to coach' do
      expect(EmployeeRegistration.reflect_on_association(:coach).macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      employee_registration = employee_registrations(:registration_one)
      expect(employee_registration).to be_valid
    end

    it 'is not valid without a user_id' do
      employee_registration = EmployeeRegistration.new(coaching_program_id: coaching_programs(:program_one).id,
                                                       coach_id: coaches(:coach_one).id)
      expect(employee_registration).not_to be_valid
      expect(employee_registration.errors[:user_id]).to include("can't be blank")
    end

    it 'is not valid without a coaching_program_id' do
      employee_registration = EmployeeRegistration.new(user_id: users(:employee_user).id, coach_id: coaches(:coach_one).id)
      expect(employee_registration).not_to be_valid
      expect(employee_registration.errors[:coaching_program_id]).to include("can't be blank")
    end

    it 'is not valid without a coach_id' do
      employee_registration = EmployeeRegistration.new(user_id: users(:employee_user).id,
                                                       coaching_program_id: coaching_programs(:program_one).id)
      expect(employee_registration).not_to be_valid
      expect(employee_registration.errors[:coach_id]).to include("can't be blank")
    end

    it 'validates uniqueness of user_id scoped to coaching_program_id and coach_id' do
      existing_registration = employee_registrations(:registration_one)
      new_registration = EmployeeRegistration.new(
        user_id: existing_registration.user_id,
        coaching_program_id: existing_registration.coaching_program_id,
        coach_id: existing_registration.coach_id
      )

      expect(new_registration).not_to be_valid
      expect(new_registration.errors[:user_id]).to include('already registered for this program with this coach')
    end
  end
end
