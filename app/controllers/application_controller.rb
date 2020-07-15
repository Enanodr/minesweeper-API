class ApplicationController < ActionController::API
  # i18n configuration. See: http://guides.rubyonrails.org/i18n.html
  before_action :set_locale

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { status: 400, message: exception.message }, status: :bad_request
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: locale }
  end

  # for devise to redirect with locale
  def self.default_url_options(options = {})
    options.merge(locale: I18n.locale)
  end

  def index
    render json: { message: 'Welcome to Rails Bootstrap' }
  end
end
