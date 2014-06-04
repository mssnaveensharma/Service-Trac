class Admin::ServiceCentersController < ApplicationController
  before_action :set_admin_service_center, only: [:show, :edit, :update, :destroy]

  # GET /admin/service_centers
  # GET /admin/service_centers.json
  def index
    @admin_service_centers = Admin::ServiceCenter.all
  end

  # GET /admin/service_centers/1
  # GET /admin/service_centers/1.json
  def show
  end

  # GET /admin/service_centers/new
  def new
    @admin_service_center = Admin::ServiceCenter.new
  end

  # GET /admin/service_centers/1/edit
  def edit
  end

  # POST /admin/service_centers
  # POST /admin/service_centers.json
  def create
    @admin_service_center = Admin::ServiceCenter.new(admin_service_center_params)

    respond_to do |format|
      if @admin_service_center.save
        format.html { redirect_to @admin_service_center, notice: 'Service center was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_service_center }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_service_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/service_centers/1
  # PATCH/PUT /admin/service_centers/1.json
  def update
    respond_to do |format|
      if @admin_service_center.update(admin_service_center_params)
        format.html { redirect_to @admin_service_center, notice: 'Service center was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_service_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/service_centers/1
  # DELETE /admin/service_centers/1.json
  def destroy
    @admin_service_center.destroy
    respond_to do |format|
      format.html { redirect_to admin_service_centers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_service_center
      @admin_service_center = Admin::ServiceCenter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_service_center_params
      params.require(:admin_service_center).permit(:Name, :State, :StateCode, :City, :Pin, :Tel, :Fax, :Email, :Url, :ContactPerson, :lat, :lan)
    end
end
