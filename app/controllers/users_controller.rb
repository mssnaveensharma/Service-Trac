class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
  end

  def show
  end

 

  def create
  end

  

 
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      #params.require(:user).permit!
      params.require(:user).permit(:eobr_make_id,:eobr_model_id,:EobrNumber,:TruckNumber,:truckmake,:TruckYear,:TruckOwner,:CompanyName,:FirstName,:LastName,:email,:encrypted_password,:password_confirmation,:Language)
    end
end
