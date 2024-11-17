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
    policy_name = exception.policy.class.to_s.underscore.gsub('_policy', '')
    action = exception.query.to_s.chomp('?')
    resource_scope = policy_name.pluralize
    translation_key = "#{resource_scope}.errors.#{policy_name}_policy.#{action}"
    message = I18n.t(translation_key)
    render json: { error: message }, status: :forbidden
  end
end
