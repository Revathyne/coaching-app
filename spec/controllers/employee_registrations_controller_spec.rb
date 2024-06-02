require 'rails_helper'

RSpec.describe EmployeeRegistrationsController, type: :controller do
  include Devise::Test::IntegrationHelpers
  include Devise::Test::ControllerHelpers
  fixtures :users, :companies, :coaching_programs, :coaches

  describe 'POST #create' do
    let(:user) { users(:employee_user) }
    let(:company) { companies(:company_one) }
    let(:coaching_program) { coaching_programs(:program_one) }
    let(:coach) { coaches(:coach_one) }

    before do
      sign_in user
    end

    context 'with valid parameters' do
      let(:params) do
        {
          coaching_program_id: coaching_program.id,
          phone: '1234567890',
          coach_id: coach.id,
          address: '123 Main St'
        }
      end

      it 'creates a new employee registration' do
        expect do
          post :create, params: params
        end.to change(EmployeeRegistration, :count).by(1)
      end

      it 'redirects to employee coaching path' do
        post :create, params: params
        expect(response).to redirect_to(employee_coaching_path)
      end

      it 'sets a success notice' do
        post :create, params: params
        expect(flash[:notice]).to eq('Employee registered successfully.')
      end
    end

    context 'with invalid parameters' do
      let(:params) { { coaching_program_id: coaching_program.id } }

      it 'does not create a new employee registration' do
        expect do
          post :create, params: params
        end.not_to change(EmployeeRegistration, :count)
      end

      it 'redirects to new employee registration path' do
        post :create, params: params
        expect(response).to redirect_to(new_employee_registration_path)
      end

      it 'sets an alert flash message' do
        post :create, params: params
        expect(flash[:alert]).to eq('Registration failed. Please try again.')
      end
    end
  end
end
