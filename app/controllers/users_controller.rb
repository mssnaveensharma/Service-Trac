class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate
  def index
  end

  
  def register_app_user
    if(params[:email] and params[:password] and params[:FirstName] and params[:LastName] and params[:EobrNumber] and params[:eobr_make_id] and params[:eobr_model_id] and params[:TruckNumber] and params[:truckmake] and params[:TruckYear] and params[:TruckOwner] and params[:CompanyName] and params[:tech_support] and params[:Contact] and params[:device_type] and params[:device_token])
       
      @response = User.create({
          :email=>params[:email],
          :password=>params[:password],
          :FirstName=>params[:FirstName],
          :LastName=>params[:LastName],
          :EobrNumber=>params[:EobrNumber],
          :Contact=>params[:Contact],
          :eobr_make_id=>params[:eobr_make_id],
          :eobr_model_id=>params[:eobr_model_id],
          :TruckNumber=>params[:TruckNumber],
          :TruckMake=>params[:truckmake],
          :TruckYear=>params[:TruckYear],
          :TruckOwner=>params[:TruckOwner],
          :company_id=>params[:CompanyName],
          :tech_support_id=>params[:tech_support],
          :Language=>params[:Language],
          :Role=>"AppUser",
          :device_type=>params[:device_type],
          :device_token=>params[:device_token],

        });

      if(@response.id !='' and @response.id != nil)
        return render :json => {:success => "true", :message => @response}
      else
        return render :json => {:success => "false", :message => @response.errors}
      end
  end
end

def login
  if(params[:email] != "" and params[:password] != "" and params[:device_type] !='' and params[:device_token] !='' )
  user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
        @update = User.where('id= ?', user.id).update_all(device_type: params[:device_type], device_token: params[:device_token])
          if(@update == 1)
            return render :json => {:success => true, :id => user.id, :email => user.email}
          else
            return render :json => {:success => false, :message => "Invalid email or password"}
          end
    else
      return render :json => {:success => false, :message => "Invalid email or password"}    
    end
  else
      return render :json => {:success => false, :message => "Required perameters are missing"}
  end
end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      #params.require(:user).permit!
      params.require(:user).permit(:eobr_make_id,:eobr_model_id,:EobrNumber,:TruckNumber,:truckmake,:TruckYear,:TruckOwner,:CompanyName,:FirstName,:LastName,:email,:encrypted_password,:password_confirmation,:Language,:device_type,:device_token)
    end
    
end
