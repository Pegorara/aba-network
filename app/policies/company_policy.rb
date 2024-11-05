class CompanyPolicy < ApplicationPolicy
  def index?
    user.admin?  
  end

  def show?
    user.present? && user.admin?  
  end

  def create?
    user.admin?  
  end

  def update?
    user.admin?  
  end

  def destroy?
    user.admin?  
  end

  def permitted_attributes
    [:name, :cnpj]
  end

  class Scope < Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user&.admin? # Use safe navigation operator para evitar erro se @user for nil
        @scope.all  
      else
        @scope.none  
      end
    end
  end
end
