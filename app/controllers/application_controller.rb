class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!,unless: :devise_controller?
  
  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    render json: { error: I18n.t("errors.#{policy_name}.#{exception.query}") }, status: :forbidden
  end
end
