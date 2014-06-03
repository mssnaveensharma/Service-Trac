class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :FirstName, :LastName, :EobrNumber, :eobr_make_id, :eobr_model_id, :TruckNumber, :truckmake, :TruckYear, :TruckOwner, :CompanyName , :Language, :tech_support) }
  end
end
