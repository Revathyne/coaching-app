require 'rails_helper'

RSpec.describe EmployeeCoachingController, type: :controller do
  include Devise::Test::IntegrationHelpers
  include Devise::Test::ControllerHelpers
  fixtures :users, :companies, :coaching_programs, :coaches, :employee_registrations

  describe 'GET #index' do
    let(:user) { users(:employee_user) }
    let(:company) { companies(:company_one) }

    before do
      sign_in user
      get :index
    end

    it 'assigns the user, company, and coaching programs' do
      expect(assigns(:employee)).to eq(user)
      expect(assigns(:company)).to eq(user.company)
      expect(assigns(:coaching_programs)).to_not be_nil
    end

    it 'builds coaching programs data correctly' do
      employee_registrations = user.employee_registrations
      expected_data = employee_registrations.map do |employee_registration|
        {
          coaching_program_name: employee_registration.coaching_program.name,
          coaching_program_description: employee_registration.coaching_program.description,
          coach_name: employee_registration.coach.user.name
        }
      end

      expect(assigns(:coaching_programs)).to eq(expected_data)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end
end
