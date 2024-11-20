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
    user.present? && record.users.include?(user)
  end

  def destroy?
    user.present? && record.users.include?(user)
  end

  def permitted_attributes
    [:content, :user_id, :published]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.includes(:users).where(published: true)
    end
  end
end
