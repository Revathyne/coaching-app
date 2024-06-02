class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
      can :access, :rails_admin
      can :dashboard
    elsif user.coach?
      can :read, :all
      can :manage, CoachingSession
    elsif user.employee?
      can :read, CoachingProgram
      can :create, EmployeeRegistration
    end
  end
end
