require 'rails_helper'

RSpec.describe CoachesController, type: :controller do
  include Devise::Test::IntegrationHelpers
  include Devise::Test::ControllerHelpers

  fixtures :coaches, :users, :coaching_programs, :companies, :employee_registrations

  describe 'GET #index' do
    it 'assigns @coach, @coaching_programs, @companies, and @employee_registrations' do
      coach = coaches(:coach_one)
      user = users(:coach_one_user)
      sign_in user

      get :index

      expect(assigns(:coach)).to eq(coach)
      expect(assigns(:coaching_programs)).to match_array(coach.coaching_programs.distinct)
      expect(assigns(:companies)).to match_array(Company.where(id: coach.coaching_programs.pluck(:company_id)))
      expect(assigns(:employee_registrations)).to match_array(coach.employee_registrations.includes(:user, :coaching_program))
    end
  end

  describe 'GET #filter_sessions' do
    it 'filters employee registrations based on company_id and coaching_program_id' do
      coaches(:coach_one)
      user = users(:coach_one_user)
      sign_in user

      get :filter_sessions, params: { company_id: companies(:company_one).id, coaching_program_id: coaching_programs(:program_one).id }, format: :js

      expect(response).to render_template('coaches/_sessions_list')
    end
  end
end
