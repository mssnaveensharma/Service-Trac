class UsersServiceCentersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_users_service_center, only: [:show, :edit, :update, :destroy]

  # GET /users_service_centers
  # GET /users_service_centers.json
  def index
    @users_service_centers = UsersServiceCenter.all
  end

  # GET /users_service_centers/1
  # GET /users_service_centers/1.json
  def show
  end

  # GET /users_service_centers/new
  def new
    @users_service_center = UsersServiceCenter.new
  end

  # GET /users_service_centers/1/edit
  def edit
  end

  # POST /users_service_centers
  # POST /users_service_centers.json
  

  # PATCH/PUT /users_service_centers/1
  # PATCH/PUT /users_service_centers/1.json
  def update
    respond_to do |format|
      if @users_service_center.update(users_service_center_params)
        format.html { redirect_to @users_service_center, notice: 'Users service center was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @users_service_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users_service_centers/1
  # DELETE /users_service_centers/1.json
  def destroy
    @users_service_center.destroy
    respond_to do |format|
      format.html { redirect_to users_service_centers_url }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_users_service_center
      @users_service_center = UsersServiceCenter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def users_service_center_params
      #params[:users_service_center]
      params.require(:users_service_center).permit(:FirstName,:LastName,:Contact,:service_center_id,:user_id)
    end
end
