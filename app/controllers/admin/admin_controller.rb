class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :disallowdispatchuser, only: [:index,:manage_dispatch_user, :manage_dispatch_user_edit]
  def index
    
  end

  def manage_company_user
     @users = User.where('("Role" = ? )', "CompanyUser")
  end

  def edit_company_user
     @companies = Admin::Company.all
  end

end
