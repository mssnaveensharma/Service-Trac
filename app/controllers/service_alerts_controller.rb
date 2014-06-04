class ServiceAlertsController < ApplicationController
  before_action :set_service_alert, only: [:show, :edit, :update, :destroy]

  # GET /service_alerts
  # GET /service_alerts.json
  def index
    @service_alerts = ServiceAlert.all
  end

  # GET /service_alerts/1
  # GET /service_alerts/1.json
  def show
  end

  # GET /service_alerts/new
  def new
    @service_alert = ServiceAlert.new
  end

  # GET /service_alerts/1/edit
  def edit
  end

  # POST /service_alerts
  # POST /service_alerts.json
  def create
    @service_alert = ServiceAlert.new(service_alert_params)

    respond_to do |format|
      if @service_alert.save
        format.html { redirect_to @service_alert, notice: 'Service alert was successfully created.' }
        format.json { render action: 'show', status: :created, location: @service_alert }
      else
        format.html { render action: 'new' }
        format.json { render json: @service_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /service_alerts/1
  # PATCH/PUT /service_alerts/1.json
  def update
    respond_to do |format|
      if @service_alert.update(service_alert_params)
        format.html { redirect_to @service_alert, notice: 'Service alert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @service_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_alerts/1
  # DELETE /service_alerts/1.json
  def destroy
    @service_alert.destroy
    respond_to do |format|
      format.html { redirect_to service_alerts_url }
      format.json { head :no_content }
    end
  end

  def driver_status
    if(params[:user_id] !='' and params[:service_center_id] !='' and [:status] !='')
        @alerts = ServiceAlert.create({
            :user_id=>params[:user_id],
            :service_center_id=>params[:service_center_id],
            :status=>params[:status]
          });
        if(@alerts.id !='' and @alerts.id !=nil)
          return render :json => {:success => "true", :message => "User location is updated succesfully"}
        else
          return render :json => {:success => "false", :message => @alerts..errors}
        end

      else
        return render :json => {:success => "false", :message => "Missing perameters or invalid request method"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_alert
      @service_alert = ServiceAlert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_alert_params
      params[:service_alert]
    end
end
