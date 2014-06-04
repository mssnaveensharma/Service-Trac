class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  TOKEN = "244438447039356867795f41713761393c446c393a4e5f3a6535595f24"
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :FirstName, :LastName, :EobrNumber, :eobr_make_id, :eobr_model_id, :TruckNumber, :TruckMake, :TruckYear, :TruckOwner, :company_id , :Language, :tech_support_id, :Contact) }
  end
  
  def authenticate
      if current_user!=nil && current_user.Role=='admin'
       return true
      else
          authenticate_or_request_with_http_token do |token, options|
            token.to_s == TOKEN.to_s
          end
      end 
  end
  
  
  def allow_admin_access
      if current_user!=nil && !current_user.Role=='admin'
       flash[:notice] = 'You are not authorized to access this location'
       redirect_to new_user_session_path
       return
     end
 end
end
