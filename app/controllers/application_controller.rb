class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!, unless: :devise_controller?

  def handle_record_invalid(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    message = I18n.t("errors.#{policy_name}.#{exception.query}")
    render json: { error: message }, status: :forbidden
  end  
end
