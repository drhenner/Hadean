class AdminAbility
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user will not be allowed in the admin section
    
    if user.super_admin?
      can :manage, :all
    elsif user.admin?
      #can :manage, :all
      
      can :view_users, User do
        user.admin?
      end
      #authorize! :view_users, @user
      can :create_users, User do
        user.admin?
      end
      #authorize! :create_users, @user
    else
      
    end
  end
end
