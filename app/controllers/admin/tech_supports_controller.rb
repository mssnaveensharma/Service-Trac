class Admin::TechSupportsController < ApplicationController
  before_action :set_admin_tech_support, only: [:show, :edit, :update, :destroy]
  before_filter :allow_admin_access, only: [:create, :edit, :update, :destroy,:new]
  before_action :authenticate, only: [:index]
  before_action :disallowdispatchuser, only: [:index,:create, :edit, :update, :destroy,:new]
  # GET /admin/tech_supports
  # GET /admin/tech_supports.json
  def index
    @admin_tech_supports = Admin::TechSupport.all
  end

  # GET /admin/tech_supports/1
  # GET /admin/tech_supports/1.json
  def show
  end

  # GET /admin/tech_supports/new
  def new
    @admin_tech_support = Admin::TechSupport.new
  end

  # GET /admin/tech_supports/1/edit
  def edit
  end

  # POST /admin/tech_supports
  # POST /admin/tech_supports.json
  def create
    @admin_tech_support = Admin::TechSupport.new(admin_tech_support_params)

    respond_to do |format|
      if @admin_tech_support.save
        format.html { redirect_to @admin_tech_support, notice: 'Tech support was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_tech_support }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_tech_support.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/tech_supports/1
  # PATCH/PUT /admin/tech_supports/1.json
  def update
    respond_to do |format|
      if @admin_tech_support.update(admin_tech_support_params)
        format.html { redirect_to @admin_tech_support, notice: 'Tech support was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_tech_support.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/tech_supports/1
  # DELETE /admin/tech_supports/1.json
  def destroy
    @admin_tech_support.destroy
    respond_to do |format|
      format.html { redirect_to admin_tech_supports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_tech_support
      @admin_tech_support = Admin::TechSupport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_tech_support_params
      params.require(:admin_tech_support).permit(:SupportDescription)
    end
end
