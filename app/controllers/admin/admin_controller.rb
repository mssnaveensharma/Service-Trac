class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :disallowdispatchuser, only: [:index,:manage_dispatch_user, :manage_dispatch_user_edit]
  def index
    
  end

  def manage_dispatch_user
     @users = User.where('("Role" = ? )', "DispatchUser")
  end

  def manage_dispatch_user_edit
     @service_centers = Admin::ServiceCenter.all
  end

end
