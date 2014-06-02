class ElectronicsController < ApplicationController
  before_action :set_electronic, only: [:show, :edit, :update, :destroy]

  # GET /electronics
  # GET /electronics.json
  def index
    @electronics = Electronic.all
  end

  # GET /electronics/1
  # GET /electronics/1.json
  def show
  end

  # GET /electronics/new
  def new
    @electronic = Electronic.new
  end

  # GET /electronics/1/edit
  def edit
  end

  # POST /electronics
  # POST /electronics.json
  def create
    @electronic = Electronic.new(electronic_params)

    respond_to do |format|
      if @electronic.save
        format.html { redirect_to @electronic, notice: 'Electronic was successfully created.' }
        format.json { render action: 'show', status: :created, location: @electronic }
      else
        format.html { render action: 'new' }
        format.json { render json: @electronic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /electronics/1
  # PATCH/PUT /electronics/1.json
  def update
    respond_to do |format|
      if @electronic.update(electronic_params)
        format.html { redirect_to @electronic, notice: 'Electronic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @electronic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /electronics/1
  # DELETE /electronics/1.json
  def destroy
    @electronic.destroy
    respond_to do |format|
      format.html { redirect_to electronics_url }
      format.json { head :no_content }
    end
  end

  def getmodal      #get the modal when the make is selected
    if(params[:make] != '' and params[:make] != nil)
      @electronics = Electronic.where(:make => params[:make])
      respond_to do |format|
          format.json {render :layout=>false , :json => @electronics}   #return the json response to ajax
      end
    else
      @electronics = {"success" => 0 , "message" => "No modals for selected make"}
      respond_to do |format|
          format.json {render :layout=>false , :json => @electronics}   #return the json response to ajax
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_electronic
      @electronic = Electronic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def electronic_params
      #params[:electronic]
      params.require(:electronic).permit(:s_no, :make, :model)
    end

end
