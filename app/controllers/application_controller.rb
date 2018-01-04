class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :prepare_exception_notifier

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  def index

  end


  # This should be called when the app is deployed to ensure that
  # exception notifications are working in the production environment, and perhaps also called periodically
  # to ensure notifications are working between deployments.
  def test_exception_notifications
    raise 'This is a just a test of the exception notifications to ensure they are working.'
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
    @language_change_allowed = request.get? || (self.is_a? Devise::SessionsController)
  end


  def default_url_options
    { locale: I18n.locale }
  end


  def after_sign_in_path_for(resource)
    return admin_root_path if resource.admin?

    information_path
  end


  def user_not_authorized
    flash[:alert] = t('errors.not_permitted')
    redirect_back(fallback_location: root_path)
  end


  def current_user # Override Devise helper method (controller instance method)
    super || Visitor.new
  end


  def user_signed_in? # Override Devise helper method
    return false if current_user.is_a? Visitor
    true
  end


  # Set data that will be included when an exception notification is sent
  #  current_user: so we know who was using the application when the error occured
  #  remote_addr: IP address to help identify bots and webcrawlers
  def prepare_exception_notifier
    request.env["exception_notifier.exception_data"] = {
        current_user: current_user.inspect,
        remote_addr: request.env['REMOTE_ADDR'],
        browser: request.env['HTTP_USER_AGENT']

    }
  end


  # When one of our URLS is cut and pasted in Facebook (FB), FB will actually
  # _change_ the URL.  Then anyone in FB clicking on the URL will be taken
  # to our system with a (possibly) invalid URL.
  # Ex:  I want to share the list of dog groomers in Skåne (a region) with someone.
  #   I do a search for all companies in Skäne with dog groomers.  I copy that resulting URL
  #   and share it with my friends in FB.  One of my friends clicks on it but
  #   because FB has mangled the URL, it no longer works and causes a 500 or 404 error.
  #
  # Specifically, FB may change  a value that should be an Array to a Hash.
  # It's pretty clear that FB is converting our params to JSON,
  # and then just serving that JSON right back to us without backing out the conversion.
  #
  # This method 'undoes' the changes that Facebook makes.
  # This is important for the Ransack gem, which we use for searching and sorting in some views.
  # (Search for the `.ransack` method in controllers.)
  # Ransack expects the parameters with the 'q' key to have values that are Arrays, not Hashes.
  #
  def fix_FB_changed_q_params(params)

    if params.key? 'q'
      params['q'].each_pair do |key, value|
        params['q'][key] = value.values if params['q'].to_unsafe_h[key].is_a?(Hash)
      end
    end

    params
  end


end
