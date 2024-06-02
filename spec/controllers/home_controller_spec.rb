# spec/controllers/home_controller_spec.rb
require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  include Devise::Test::IntegrationHelpers
  include Devise::Test::ControllerHelpers
  fixtures :users, :companies

  describe 'GET #index' do
    context 'when user is an admin' do
      let(:admin_user) { users(:admin_user) }

      before do
        sign_in admin_user
      end

      it 'redirects to Rails Admin path' do
        get :index
        expect(response).to redirect_to rails_admin_path
      end
    end

    context 'when user is a coach' do
      let(:coach_user) { users(:coach_one_user) }

      before do
        sign_in coach_user
      end

      it 'redirects to coach dashboard path' do
        get :index
        expect(response).to redirect_to coach_dashboard_path
      end
    end

    context 'when user is an employee and associated with a company' do
      let(:employee_user) { users(:employee_user) }

      before do
        sign_in employee_user
      end

      it 'redirects to employee coaching path' do
        get :index
        expect(response).to redirect_to employee_coaching_path
      end
    end

    context 'when user is an employee but not associated with any company' do
      let(:employee_user_without_company) { users(:employee_user_without_company) }

      before do
        sign_in employee_user_without_company
      end

      it 'sets a flash alert' do
        get :index
        expect(flash[:alert]).to eq('You are not associated with any company. Please contact with the admin to associate company')
      end

      it 'signs out the user' do
        expect(subject).to receive(:sign_out).with(employee_user_without_company)
        get :index
      end

      it 'redirects to the new user session path' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user has an invalid role' do
      let(:invalid_user) { users(:invalid_user) }

      before do
        sign_in invalid_user
      end

      it 'sets a flash alert' do
        get :index
        expect(flash[:alert]).to eq('Invalid role.')
      end

      it 'signs out the user' do
        expect(subject).to receive(:sign_out).with(invalid_user)
        get :index
      end

      it 'redirects to the new user session path' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
