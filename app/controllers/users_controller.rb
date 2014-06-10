class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate
  def index
  end

  
  def register_app_user
   if(params[:email] !='' and params[:password] !='' and params[:FirstName] !='' and params[:LastName] !='' and params[:EobrNumber] !='' and params[:eobr_make_id] !='' and params[:eobr_model_id] !='' and params[:TruckModel] !='' and params[:TruckNumber] !='' and params[:truckmake] !='' and params[:TruckYear] !='' and params[:TruckOwner] !='' and params[:CompanyName] !='' and params[:tech_support] !='' and params[:Contact] !='' and params[:device_type] !='' and params[:device_token] !='')
       if params[:device_type] == 'wp' 
        if params[:wp_notification_url] != ''
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
              :TruckModel=>params[:TruckModel],
              :company_id=>params[:CompanyName],
              :tech_support_id=>params[:tech_support],
              :Language=>params[:Language],
              :Role=>"AppUser",
              :device_type=>params[:device_type],
              :device_token=>params[:device_token],
              :wp_notification_url=>params[:wp_notification_url],
              :plain_password=>params[:password]

            });

      if(@response.id !='' and @response.id != nil)
        return render :json => {:success => "true", :message => @response}
      else
        return render :json => {:success => "false", :message => @response.errors}
      end
    else
        return render :json => {:success => "false", :message => "Device uri is required"}
    end
    else
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
              :TruckModel=>params[:TruckModel],
              :company_id=>params[:CompanyName],
              :tech_support_id=>params[:tech_support],
              :Language=>params[:Language],
              :Role=>"AppUser",
              :device_type=>params[:device_type],
              :device_token=>params[:device_token],
              :plain_password=>params[:password]            

            });
           if(@response.id !='' and @response.id != nil)
              return render :json => {:success => "true", :message => @response}
            else
              return render :json => {:success => "false", :message => @response.errors}
            end
    end
  end
end

def login
  if(params[:email] != "" and params[:password] != "" and params[:device_type] !='' and params[:device_token] !='' and params[:lat] != '' and params[:lan] != '')
  user = User.authenticate(params[:email], params[:password])
    if user
       session[:user_id] = user.id
       if params[:device_type] == 'wp'
           if params[:wp_notification_url] != ''
            @update = User.where('id= ?', user.id).update_all(lat: params[:lat], lan: params[:lan], device_type: params[:device_type], device_token: params[:device_token], wp_notification_url: params[:wp_notification_url])
              if(@update == 1)
                return render :json => {:success => true, :id => user.id, :email => user.email, :lat => params[:lat], :lan => params[:lan]}
              else
                return render :json => {:success => false, :message => "Invalid email or password"}
              end
            else
                return render :json => {:success => false, :message => "Device url is reqiured"}
            end
        else
       @update = User.where('id= ?', user.id).update_all(lat: params[:lat], lan: params[:lan], device_type: params[:device_type], device_token: params[:device_token])
          if(@update == 1)
            return render :json => {:success => true, :id => user.id, :email => user.email, :lat => params[:lat], :lan => params[:lan]}
          else
            return render :json => {:success => false, :message => "Invalid email or password"}
          end
         end

    else
      return render :json => {:success => false, :message => "Invalid email or password"}    
    end
  else
      return render :json => {:success => false, :message => "Required perameters are missing"}
  end
end
  
def settings
  if params[:user_id] != '' and params[:user_id] != nil and params[:email] == ''
    @user = User.where(:id => params[:user_id])
      if @user.length != 0
        return render :json => {:success => true, :user_info => @user}
      else
        return render :json => {:success => false, :message => "Invalid user id"}
      end

 elsif(params[:user_id] != '' and params[:email] !='' and params[:password] !='' and params[:FirstName] !='' and params[:LastName] !='' and params[:EobrNumber] !='' and params[:eobr_make_id] !='' and params[:eobr_model_id] !='' and params[:TruckNumber] !='' and params[:TruckModel] !='' and params[:truckmake] !='' and params[:TruckYear] !='' and params[:TruckOwner] !='' and params[:company_id] !='' and params[:tech_support] !='' and params[:Contact] !='' and params[:device_type] !='' and params[:device_token] !='' and params[:Language] != '')
       if params[:device_type] == 'wp' 
        if params[:wp_notification_url] != ''
          @response = User.where('id= ?', params[:user_id]).update_all(FirstName: params[:FirstName], LastName: params[:LastName], EobrNumber: params[:EobrNumber], eobr_make_id: params[:eobr_make_id], eobr_model_id: params[:eobr_model_id], TruckYear: params[:TruckYear], TruckNumber: params[:TruckNumber],TruckOwner: params[:TruckOwner], TruckModel: params[:TruckModel], TruckMake: params[:truckmake], company_id: params[:CompanyName], tech_support_id: params[:tech_support], Contact: params[:Contact], device_type: params[:device_type], device_token: params[:device_token], Language: params[:Language], wp_notification_url: params[:wp_notification_url], plain_password: params[:password])
          user = User.update_password(params[:email], params[:new_password])
      if(@response == 1 and user != nil and user != '')
        @update_pass = User.where('id= ?', params[:user_id]).update_all(encrypted_password: user)
                  if @update_pass == 1
                    return render :json => {:success => "true", :message => "Profile information is updated successfully"}
                  else
                    return render :json => {:success => false, :message => "Current password is incorrect" }
                  end
              return render :json => {:success => "true", :message => "Profile information is updated successfully" }
      else
        return render :json => {:success => "false", :message => "Required fields are missing in the request"}
      end
    else
        return render :json => {:success => "false", :message => "Device uri is required"}
    end
    else
          @response = User.where('id= ?', params[:user_id]).update_all(FirstName: params[:FirstName], LastName: params[:LastName], EobrNumber: params[:EobrNumber], eobr_make_id: params[:eobr_make_id], eobr_model_id: params[:eobr_model_id], TruckMake: params[:truckmake], TruckYear: params[:TruckYear], TruckNumber: params[:TruckNumber],TruckOwner: params[:TruckOwner], TruckModel: params[:TruckModel], company_id: params[:CompanyName], tech_support_id: params[:tech_support], Contact: params[:Contact], device_type: params[:device_type], device_token: params[:device_token], Language: params[:Language], plain_password: params[:password])
            user = User.update_password(params[:email], params[:new_password])
           if(@response == 1 and user != nil and user != '')
                  @update_pass = User.where('id= ?', params[:user_id]).update_all(encrypted_password: user)
                  if @update_pass == 1
                    return render :json => {:success => "true", :message => "Profile information is updated successfully", :pass => user }
                  else
                    return render :json => {:success => false, :message => "Current password is incorrect", :pass => user }
                  end
              return render :json => {:success => "true", :message => "Profile information is updated successfully", :pass => user }
            else
              return render :json => {:success => "false", :message => "Required perameters are mssing in the request"}
            end
    end
  end
end

def recover_password
  if params[:email] != '' and params[:email] != nil
    @pass = User.where(:email => params[:email])
      if @pass.length != 0
        @pass.each do |password|
          @user_pass = password.plain_password
        end
          return render :json => {:success => true, :password => @user_pass}
      else
          return render :json => {:success => false, :message => "Invalid user id"}
      end
  else
      return render :json => {:success => false, :message => "User id is required"}
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
      params.require(:user).permit(:eobr_make_id,:eobr_model_id,:EobrNumber,:TruckNumber,:TruckMake,:TruckYear,:TruckOwner,:TruckModel,:CompanyName,:FirstName,:LastName,:email,:encrypted_password,:password_confirmation,:Language,:device_type,:device_token,:wp_notification_url)
    end
    
end
