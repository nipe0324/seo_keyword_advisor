class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  if Rails.env.production?
    raise 'ENV["HTTP_BASIC_NAME"] must be needed'     if ENV["HTTP_BASIC_NAME"].blank?
    raise 'ENV["HTTP_BASIC_PASSWORD"] must be needed' if ENV["HTTP_BASIC_PASSWORD"].blank?
    http_basic_authenticate_with name: ENV["HTTP_BASIC_NAME"], password: ENV["HTTP_BASIC_PASSWORD"]
  end
end
