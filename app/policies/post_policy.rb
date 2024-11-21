class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && (record.users.include?(user) || user.admin? || user.moderator?)
  end

  def destroy?
    user.present? && (record.users.include?(user) || user.admin? || user.moderator?)
  end

  def permitted_attributes
    [:content, :user_id, :published]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.includes(:users)
    end
  end
end
