class AlertDetailsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_alert_detail, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:get_route]

  # GET /alert_details
  # GET /alert_details.json
  def index
    @alert_details = ServiceAlert.where('(status != ? )', "cancel")
  end

  # GET /alert_details/1
  # GET /alert_details/1.json
  def show
  end

  # GET /alert_details/new
  def new
    @alert_detail = AlertDetail.new
  end

  # GET /alert_details/1/edit
  def edit
  end

  # POST /alert_details
  # POST /alert_details.json
  def create
    @alert_detail = AlertDetail.new(alert_detail_params)

    respond_to do |format|
      if @alert_detail.save
        format.html { redirect_to @alert_detail, notice: 'Alert detail was successfully created.' }
        format.json { render action: 'show', status: :created, location: @alert_detail }
      else
        format.html { render action: 'new' }
        format.json { render json: @alert_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alert_details/1
  # PATCH/PUT /alert_details/1.json
  def update
    respond_to do |format|
      if @alert_detail.update(alert_detail_params)
        format.html { redirect_to @alert_detail, notice: 'Alert detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @alert_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alert_details/1
  # DELETE /alert_details/1.json
  def destroy
    @alert_detail.destroy
    respond_to do |format|
      format.html { redirect_to alert_details_url }
      format.json { head :no_content }
    end
  end

  def get_route
    if(params[:id] != '' and params[:id] != nil)
      data = Array.new
      @alert_location = ServiceAlert.where(:id => params[:id])
        @alert_location.each do |alert|
          @center_location = Admin::ServiceCenter.where(:id => alert.service_center_id)
            @users = User.where(:id => alert.user_id)
              @users.each do |user|
                @contact = user.Contact
                @eobr_number = user.EobrNumber
                @truck_year = user.TruckYear
                @truck_make = user.TruckMake
                  @eobr_make = Admin::EobrMake.where(:id => user.eobr_make_id)
                    @eobr_make.each do |make|
                      @eobr_make_name = make.Name
                    end
                    @eobr_model = Admin::EobrModel.where(:id => user.eobr_model_id)
                      @eobr_model.each do |model|
                        @eobr_model_name = model.Name
                      end
                    @tech_support = Admin::TechSupport.where(:id => user.tech_support_id)
                      @tech_support.each do |driver_support|
                        @driver_assist = driver_support.SupportDescription
                      end
              end
                @center_location.each do |center|
                  response = Hash.new
                  response[:driver_lat]=alert.lat
                  response[:driver_lan]=alert.lan
                  response[:center_lat]=center.lat
                  response[:center_lan]=center.lan
                  response[:contact]=@contact
                  response[:truck_year]=@truck_year
                  response[:truck_make]=@truck_make
                  response[:eobr_number]=@eobr_number
                  response[:eobr_make]=@eobr_make_name
                  response[:eobr_model]=@eobr_model_name
                  response[:driver_assist]=@driver_assist
                  data.push(response)
                end
        end
      return render :json =>  data
    else
      return render :json => {:success => false, :data => "Required fields are missing "}     
    end
  end

  def edit_alert
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert_detail
      @alert_detail = AlertDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alert_detail_params
      params[:alert_detail]
    end
end
