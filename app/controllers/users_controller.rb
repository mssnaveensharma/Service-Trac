class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate
  def index
  end

  
  def register_app_user
   if(params[:email] !='' and params[:password] !='' and params[:FirstName] !='' and params[:LastName] !='' and params[:eobr_make_id] !='' and params[:TruckModel] !='' and params[:TruckNumber] !='' and params[:truckmake] !='' and params[:TruckYear] !='' and params[:TruckOwner] !='' and params[:CompanyName] and params[:CompanyName] !=0 and params[:CompanyName] !='' and params[:tech_support] !='' and params[:Contact] !='' and params[:device_type] !='' and params[:device_token] !='')
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
              :plain_password=>params[:password],
              :support_call => "0"
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
              :plain_password=>params[:password],
              :support_call => "0"            

            });
           if(@response.id !='' and @response.id != nil)
              return render :json => {:success => "true", :message => @response}
            else
              return render :json => {:success => "false", :message => @response.errors}
            end
    end
  else
      return render :json => {:success => false, :message => "Required perameters are missing"}
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
                return render :json => {:success => true, :id => user.id, :email => user.email, :lat => params[:lat], :lan => params[:lan], :company_id => user.company_id,:eobr_make_id => user.eobr_make_id, :tech_support_id => user.tech_support_id, :user_info => user}
              else
                return render :json => {:success => false, :message => "Invalid email or password"}
              end
            else
                return render :json => {:success => false, :message => "Device url is reqiured"}
            end
        else
       @update = User.where('id= ?', user.id).update_all(lat: params[:lat], lan: params[:lan], device_type: params[:device_type], device_token: params[:device_token])
          if(@update == 1)
            return render :json => {:success => true, :id => user.id, :email => user.email, :lat => params[:lat], :lan => params[:lan], :user_info => user}
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
  
def setting
  if params[:user_id] != '' and params[:user_id] != nil and params[:email] == ''
    @user = User.where(:id => params[:user_id])
      if @user.length != 0
        return render :json => {:success => true, :user_info => @user}
      else
        return render :json => {:success => false, :message => "Invalid user id"}
      end

 elsif(params[:user_id] and params[:user_id] != '' and params[:email] and params[:email] !='' and params[:password] and params[:password] !='' and params[:FirstName] and params[:FirstName] !='' and params[:LastName] and params[:LastName] !='' and params[:eobr_make_id] and params[:eobr_make_id] !='' and params[:TruckNumber] and params[:TruckNumber] !='' and params[:TruckModel] and params[:TruckModel] !='' and params[:truckmake] and params[:truckmake] !='' and params[:TruckYear] and params[:TruckYear] !='' and params[:TruckOwner] and params[:TruckOwner] !='' and params[:company_id] and params[:company_id] !='' and params[:tech_support] and params[:tech_support] !='' and params[:Contact] and params[:Contact] !='' and params[:device_type] and params[:device_type] !='' and params[:device_type] == 'wp' and params[:device_token] !='' and params[:wp_notification_url] and params[:wp_notification_url] != '')

          @response = User.where('id= ?', params[:user_id]).update_all(FirstName: params[:FirstName], LastName: params[:LastName], EobrNumber: params[:EobrNumber], eobr_make_id: params[:eobr_make_id], TruckYear: params[:TruckYear], TruckNumber: params[:TruckNumber],TruckOwner: params[:TruckOwner], TruckModel: params[:TruckModel], TruckMake: params[:truckmake], company_id: params[:company_id], tech_support_id: params[:tech_support], Contact: params[:Contact], device_type: params[:device_type], device_token: params[:device_token], wp_notification_url: params[:wp_notification_url], plain_password: params[:password])
          user = User.find(params[:user_id])
              if(@response == 1 and user != nil and user != '')
                password_salt = BCrypt::Engine.generate_salt
                password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
                  @update_pass = user.update_attributes(encrypted_password: password_hash)
                  #@update_hash = user.update_attributes(password_hash: password_hash)
                  if @update_pass == true
                    return render :json => {:success => true, :message => "Profile information is updated successfully" }
                  else
                    return render :json => {:success => false, :message => "Password is not updated" }
                  end
              else
                  return render :json => {:success => false, :message => "Invalid user id" }
              end
    elsif(params[:user_id] and params[:user_id] != '' and params[:email] and params[:email] !='' and params[:password] and params[:password] !='' and params[:FirstName] and params[:FirstName] !='' and params[:LastName] and params[:LastName] !='' and params[:eobr_make_id] and params[:eobr_make_id] !='' and params[:TruckNumber] and params[:TruckNumber] !='' and params[:TruckModel] and params[:TruckModel] !='' and params[:truckmake] and params[:truckmake] !='' and params[:TruckYear] and params[:TruckYear] and params[:TruckYear] !='' and params[:TruckOwner] and params[:TruckOwner] !='' and params[:CompanyName] and params[:CompanyName] !='' and params[:tech_support] and params[:tech_support] !='' and params[:Contact] and params[:Contact] !='' and params[:device_type] and params[:device_type] !='' and params[:device_type] =="iphone" and params[:device_token] !='' )
          @response = User.where('id= ?', params[:user_id]).update_all(FirstName: params[:FirstName], LastName: params[:LastName], EobrNumber: params[:EobrNumber], eobr_make_id: params[:eobr_make_id], TruckMake: params[:truckmake], TruckYear: params[:TruckYear], TruckNumber: params[:TruckNumber],TruckOwner: params[:TruckOwner], TruckModel: params[:TruckModel], company_id: params[:CompanyName], tech_support_id: params[:tech_support], Contact: params[:Contact], device_type: params[:device_type], device_token: params[:device_token], plain_password: params[:password])
            user = User.find(params[:user_id])
           if(@response == 1 and user != nil)
                password_salt = BCrypt::Engine.generate_salt
                password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
                  @update_pass = user.update_attributes(encrypted_password: password_hash)
                  #@update_hash = user.update_attributes(password_hash: password_hash)
                  if @update_pass == true
                    return render :json => {:success => "true", :message => "Profile information is updated successfully"}
                  else
                    return render :json => {:success => false, :message => "Password is not updated"}
                  end
            else
                return render :json => {:success => false, :message => "Invalid user id" }
            end
      else
       return render :json => {:success => "false", :message => "Required perameters are missing in the request"}
      end
end

def getall
  @users = User.all
  
   return render :json => {:success => "true", :message => @users}
end


def recover_password
  if params[:email] != '' and params[:email] != nil
    @pass = User.where(:email => params[:email])
      if @pass.length != 0
        @pass.each do |password|
          @user_pass = password.plain_password
          user=password
          #send the password in mail
          UserMailer.sendpassword(user,request.protocol, request.host_with_port).deliver
        end
          return render :json => {:success => true, :message => "Please check your mail to get your password"}
      else
          return render :json => {:success => false, :message => "Invalid user id"}
      end
  else
      return render :json => {:success => false, :message => "User id is required"}
  end
end


def create_user
    if params[:FirstName] !='' and params[:LastName] !='' and params[:company_id] !='' and params[:user_id] and params[:user_id] !='' and params[:Contact] !=''
        @chk_center = UsersServiceCenter.where(:user_id => params[:user_id])
        @update = User.where(:id => params[:user_id]).update_all(:FirstName =>params[:FirstName], :LastName => params[:LastName], :Contact =>params[:Contact])
        if @chk_center.length == 0
          @create = UsersServiceCenter.create({
            :company_id => params[:company_id],
            :user_id => params[:user_id],
            :status => "Active"
          })

              if @create.id !='' and @create.id != nil
                 redirect_to '/admin/manage_company_user', :notice => 'Users service center was successfully updated.'
              else
                redirect_to "/admin/edit_company_user?id="+params[:user_id], :notice => 'Users service center was successfully updated.'
          end

        else
          @update = UsersServiceCenter.where(:user_id => params[:user_id]).update_all(company_id: params[:company_id])

              if(@update == 1)
                redirect_to '/admin/manage_company_user', :notice => 'User was updated succesfully.'

              else
                redirect_to '/admin/edit_company_user?id='+params[:user_id], :notice => 'Required fields are missing.'
                end
     
        end            
    elsif params[:FirstName] !='' and params[:LastName] !='' and params[:company_id] !='' and params[:Contact] !='' and params[:password] !='' and params[:email] !=''
      @response = User.create({
              :email=>params[:email],
              :password=>params[:password],
              :FirstName=>params[:FirstName],
              :LastName=>params[:LastName],
              :EobrNumber=>"1",
              :Contact=>params[:Contact],
              :eobr_make_id=>"01",
              :eobr_model_id=>"01",
              :TruckNumber=>"01",
              :TruckMake=>"01",
              :TruckYear=>"01",
              :TruckOwner=>"01",
              :TruckModel=>"01",
              :company_id=>"01",
              :tech_support_id=>"01",
              :Language=>"1",
              :Role=>"CompanyUser",
              :device_type=>"01",
              :device_token=>"01",
              :wp_notification_url=>"01",
              :plain_password=>params[:password],
              :support_call => "0"
            });
              if(@response.id != nil)
                  @create = UsersServiceCenter.create({
                    :company_id => params[:company_id],
                    :user_id => @response.id,
                    :status => "Active"
                  })
               end  
                  if(@response.id != nil and @response.id != '')
                   redirect_to '/admin/manage_company_user', :notice => 'New user created successfully'
                  else
                    session[:err] = nil
                    session[:err] = Array.new
                    @response.errors.full_messages.each do |msg|
                      response = Hash.new
                      response[:error]=msg
                      session[:err].push(response)
                    end
                    #session[:err] = arr
                 
                    redirect_to '/admin/edit_company_user' 
                 
                  end

                  #redirect_to '/admin/manage_dispatch_user_edit', :notice => 'New user created successfully'
        else
         
           redirect_to '/admin/manage_company_user', :notice => 'Required fields are missing last.'
         
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
      params.require(:user).permit(:eobr_make_id,:company_id,:eobr_model_id,:Role,:EobrNumber,:TruckNumber,:TruckMake,:TruckYear,:TruckOwner,:TruckModel,:FirstName,:LastName,:email,:encrypted_password,:password_confirmation,:Language,:device_type,:device_token,:wp_notification_url,:support_call)
    end
    
end
