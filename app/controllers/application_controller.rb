class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  def index

  end

  protected

  def configure_permitted_parameters
    additional_permissions = [:first_name, :last_name]
    devise_parameter_sanitizer.permit(:sign_up, keys: additional_permissions)
    devise_parameter_sanitizer.permit(:account_update, keys: additional_permissions)
  end

  private

  def set_locale
    @locale = I18n.default_locale
    @locale = params[:locale].to_s if params[:locale].present?
    I18n.locale = @locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    else
      information_path
    end
  end

  def user_not_authorized
    flash[:alert] = t('errors.not_permitted')
    redirect_back(fallback_location: root_path)
  end

  def current_user  # Override Devise helper method (controller instance method)
    super || Visitor.new
  end

  def user_signed_in?  # Override Devise helper method
    return false if current_user.is_a? Visitor
    true
  end
end
