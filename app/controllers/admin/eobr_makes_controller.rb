class Admin::EobrMakesController < ApplicationController
  before_action :set_admin_eobr_make, only: [:show, :edit, :update, :destroy]
  before_filter :allow_admin_access, only: [:create, :edit, :update, :destroy,:new]
  before_action :authenticate, only: [:index,:getmodal]
  before_action :disallowdispatchuser, only: [:index,:create, :edit, :update, :destroy,:new]
  # GET /admin/eobr_makes
  # GET /admin/eobr_makes.json
  def index
    @admin_eobr_makes = Admin::EobrMake.all
  end

  # GET /admin/eobr_makes/1
  # GET /admin/eobr_makes/1.json
  def show
  end

  # GET /admin/eobr_makes/new
  def new
    @admin_eobr_make = Admin::EobrMake.new
  end

  # GET /admin/eobr_makes/1/edit
  def edit
  end
  # POST /admin/eobr_makes
  # POST /admin/eobr_makes.json
  def create
    @admin_eobr_make = Admin::EobrMake.new(admin_eobr_make_params)
    respond_to do |format|
      if @admin_eobr_make.save
        format.html { redirect_to @admin_eobr_make, notice: 'Eobr make was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_eobr_make }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_eobr_make.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/eobr_makes/1
  # PATCH/PUT /admin/eobr_makes/1.json
  def update
    respond_to do |format|
      if @admin_eobr_make.update(admin_eobr_make_params)
        format.html { redirect_to @admin_eobr_make, notice: 'Eobr make was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_eobr_make.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/eobr_makes/1
  # DELETE /admin/eobr_makes/1.json
  def destroy
    @admin_eobr_make.destroy
    respond_to do |format|
      format.html { redirect_to admin_eobr_makes_url }
      format.json { head :no_content }
    end
  end

def getmodal      #get the modal when the make is selected
    if(params[:make_id] != '' and params[:make_id] != nil)
      @models =  Admin::EobrModel.where(:EobrMake_id => params[:make_id])
      respond_to do |format|
          format.json {render :json => @models}   #return the json response to ajax
      end
    else
      @models = {"success" => 0 , "message" => "No modals for selected make"}
      respond_to do |format|
          format.json {render :layout=>false , :json => @models}   #return the json response to ajax
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_eobr_make
      @admin_eobr_make = Admin::EobrMake.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_eobr_make_params
      params.require(:admin_eobr_make).permit(:Name)
    end
end
