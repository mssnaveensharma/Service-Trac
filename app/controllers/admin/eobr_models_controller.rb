class Admin::EobrModelsController < ApplicationController
  before_action :set_admin_eobr_model, only: [:show, :edit, :update, :destroy]

  # GET /admin/eobr_models
  # GET /admin/eobr_models.json
  def index
    @admin_eobr_models = Admin::EobrModel.all
  end

  # GET /admin/eobr_models/1
  # GET /admin/eobr_models/1.json
  def show
  end

  # GET /admin/eobr_models/new
  def new
    @admin_eobr_model = Admin::EobrModel.new
  end

  # GET /admin/eobr_models/1/edit
  def edit
  end

  # POST /admin/eobr_models
  # POST /admin/eobr_models.json
  def create
    @admin_eobr_model = Admin::EobrModel.new(admin_eobr_model_params)

    respond_to do |format|
      if @admin_eobr_model.save
        format.html { redirect_to @admin_eobr_model, notice: 'Eobr model was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_eobr_model }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_eobr_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/eobr_models/1
  # PATCH/PUT /admin/eobr_models/1.json
  def update
    respond_to do |format|
      if @admin_eobr_model.update(admin_eobr_model_params)
        format.html { redirect_to @admin_eobr_model, notice: 'Eobr model was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_eobr_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/eobr_models/1
  # DELETE /admin/eobr_models/1.json
  def destroy
    @admin_eobr_model.destroy
    respond_to do |format|
      format.html { redirect_to admin_eobr_models_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_eobr_model
      @admin_eobr_model = Admin::EobrModel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_eobr_model_params
      params.require(:admin_eobr_model).permit(:Name, :EobrMake_id)
    end
end
