class CommentPolicy < ApplicationPolicy
  def show?
    true
  end

  def index?
    true
  end

  def create?
    user.present? 
  end

  def new?
    create?
  end

  def update?
    user.present? && (user == record.user || user.admin? || user.moderator?)
  end
  
  def destroy?
    user.present? && (user == record.user || user.admin? || user.moderator?)
  end

  def permitted_attributes
      [:content, :commentable_id, :commentable_type]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
