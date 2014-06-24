class SettingsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  # GET /settings
  # GET /settings.json
  def index
    #@settings = Setting.all
    if user_signed_in?
      @users = User.where(:id => current_user.id)
    end

  end


  def updateProfile
    if params[:email] and params[:email] != '' and params[:password] and params[:password] !='' and params[:FirstName] and params[:FirstName] !='' and params[:check] and params[:check] !='' and params[:LastName] and params[:LastName] !=''
      @update = User.where(:id => current_user.id).update_all(:FirstName => params[:FirstName], :LastName => params[:LastName])
        if @update == 1
          user = User.find(current_user.id)
          password_salt = BCrypt::Engine.generate_salt
          password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
          @update_pass = user.update_attributes(encrypted_password: password_hash)
          redirect_to '/', :notice => 'Profile was successfully updated.'
        else
          redirect_to '/settings', :notice => 'Profile was not updated.'
        end
    elsif params[:email] and params[:email] != '' and params[:password] and params[:password] !='' and params[:FirstName] and params[:FirstName] !='' and params[:LastName] and params[:LastName] !=''
       @update = User.where(:id => current_user.id).update_all(:FirstName => params[:FirstName], :LastName => params[:LastName])
        if @update == 1
          redirect_to '/settings', :notice => 'Profile was successfully updated.'
        else
          redirect_to '/settings', :notice => 'Profile was not updated.'
        end
    else
        redirect_to '/settings', :notice => 'Please enter your password.'
    end    
  end

  # GET /settings/1
  # GET /settings/1.json
  def show
  end

  # GET /settings/new
  def new
    @setting = Setting.new
  end

  # GET /settings/1/edit
  def edit
  end

  # POST /settings
  # POST /settings.json
  def create
    @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
        format.json { render action: 'show', status: :created, location: @setting }
      else
        format.html { render action: 'new' }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to @setting, notice: 'Setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params[:setting]
    end
end
