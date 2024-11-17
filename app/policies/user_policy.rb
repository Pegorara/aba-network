class UserPolicy < ApplicationPolicy
  def index?
    true
  end
  
  def show?
    true
  end
  
  def update?
    user.present? && (user.admin? || user == record)
  end
  
  def create?
    user.admin?
  end

  def destroy?
    user.admin? || user.id == record.id 
  end

  def permitted_attributes
    if user.admin?
      [:name, :email, :password, :role, :admin]
    end
    [:name, :email, :password]
end
  

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
