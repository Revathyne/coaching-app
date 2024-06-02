RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
    redirect_to main_app.root_path unless current_user.role == 'admin'
  end
  config.current_user_method(&:current_user)

  module RailsAdmin
    module Config
      module Actions
        class ListRegisteredEmployees < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)

          register_instance_option :link_icon do
            'icon-user'
          end

          register_instance_option :http_methods do
            [:get]
          end

          register_instance_option :controller do
            proc do
              @company = Company.find(params[:id])
              @coaching_program_ids = @company.coaching_programs.pluck(:id)
              @registered_employees = EmployeeRegistration.where(coaching_program_id: @coaching_program_ids)

              render action: @action.template_name
            end
          end

          register_instance_option :route_fragment do
            'list_registered_employees'
          end

          register_instance_option :pjax? do
            false
          end
        end
      end
    end
  end

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    list_registered_employees do
      only ['Company']
    end
  end

  config.model 'User' do
    label 'Employee/Coach/Admin'
    edit do
      field :name
      field :email
      field :password
      field :password_confirmation
      field :role
      field :company
      field :phone
      field :age
      field :address
    end
  end

  config.model 'Company' do
    show do
      field :name
      field :coaching_programs
      field :description
      field :phone
      field :address
      field :registered_employees do
        formatted_value do
          bindings[:view].render partial: 'rails_admin/registered_employees', locals: { company: bindings[:object] }
        end
      end
    end

    edit do
      field :name
      field :description
      field :phone
      field :address
    end
  end

  config.model 'CoachingProgram' do
    edit do
      field :name
      field :description
      field :company
    end
  end

  config.model 'Coach' do
    visible false
    object_label_method :display_name # Use the custom display_name method for the label
  end

  config.model 'CoachCoachingProgram' do
    label 'Assign Coach to Coaching Program'
    edit do
      field :coach do
        label 'Coach'
        associated_collection_scope do
          proc { |scope| scope.joins(:user).where(users: { role: 'coach' }).distinct }
        end
      end
      field :coaching_program
    end
  end

  config.model 'EmployeeRegistration' do
    edit do
      field :user do
        label 'Employee'
        queryable true
        searchable :email

        # Fetch only users with the employee role
        associated_collection_scope do
          proc { |scope| scope.where(role: 'employee') }
        end
      end
      field :coaching_program
      field :coach do
        associated_collection_scope do
          proc { |scope| scope.where(role: 'coach') }
        end
      end
    end
  end
end
