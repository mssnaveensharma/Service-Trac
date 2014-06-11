class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  def index
    
  end

  def manage_dispatch_user
     @users = User.where('("Role" = ? )', "DispatchUser")
  end

  def manage_dispatch_user_edit
     @service_centers = Admin::ServiceCenter.all
  end

end
