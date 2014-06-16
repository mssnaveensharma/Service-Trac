class ServiceAlertsController < ApplicationController
  helper_method :get_distance
  skip_before_filter :verify_authenticity_token
  before_action :set_service_alert, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:driver_status]
  before_action :authenticate_user!, only: [:index]
  # GET /service_alerts
  # GET /service_alerts.json
  def index
    if user_signed_in?
      @user = current_user.id
    end
      @service_alerts = ServiceAlert.where('(status != ? )', "cancel")
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
    if(params[:user_id] !='' and params[:service_center_id] !='' and params[:lat] !='' and params[:lan] != '')
        @chk_user = User.where(:id => params[:user_id])  #check if user exists
        @chk_center = Admin::ServiceCenter.where(:id => params[:service_center_id]) #check if service center exists
       
        if(@chk_user.length != 0 and @chk_center.length != 0)  #if user and center are found
          #@check_diver = ServiceAlert.where(:user_id => params[:user_id])  #check for existence
            @chk_center.each do |center|
              @center_loc = center.lat+","+center.lan     #get the service center location
            end
              @user_loc = params[:lat]+","+params[:lan]    #get the user cirrent location
            if(params[:alert_id] !='' and params[:alert_id] != nil)    #if found
                @update = User.where('id= ?', params[:user_id]).update_all(lat: params[:lat], lan: params[:lan])  #update user' current location in table
                @update_service = ServiceAlert.where('id= ?', params[:alert_id]).update_all(lat: params[:lat], lan: params[:lan])  #service alert user' current location in table
                  if(@update == 1)  
                     @current_distance = get_distance @user_loc,@center_loc     #hit the google api to get the diver location distance from service center
                        @distance_array =  @current_distance['routes'] 
                          if(@distance_array !='' and @current_distance['status'] !='ZERO_RESULTS' and @current_distance['status'] != 'NOT_FOUND' and @distance_array != nil)  #if no result is found from api
                              @distance_array.each do |distance| 
                                 @distance_count = distance['legs'] 
                                    @distance_count.each do |new_distance| 
                                      @distance =  new_distance['distance']['text'].gsub(/\s.+/, '').to_i   #lotal distance in kms
                                      @time = new_distance['duration']['text'] #total time 
                                      @asst_time = new_distance['duration']['text'].gsub(/\s.+/, '').to_i
                                      @asst_distance =  new_distance['distance']['text']

                              end 
                            end
      
                            @service_status = ServiceAlert.where(:id => params[:alert_id])    #get the current alert status
                            @service_status.each do |alert_status|
                              @alert_status = alert_status.status
                            end
                                 @status = ""
                                    if(@distance >= 1 and @alert_status == 'New')
                                      @status = "In Route"
                                    elsif(@distance < 1 and @alert_status == 'In Route')
                                      @status = "Service"
                                    elsif (@distance > 1 and @alert_status == 'Service')
                                      @status = "Complete"
                                    elsif (@distance < 1 and @alert_status == 'Service')
                                      @status = "Service"
                                    elsif (@distance > 1 and @alert_status == 'Complete')
                                      @status = "Complete"
                                    else
                                      @status = "In Route"
                                    end
                                    @update_alert = ServiceAlert.where('id= ?', params[:alert_id]).update_all(service_center_id: params[:service_center_id], status: @status, asstimate_time: @asst_time, asstimate_date: @asst_time)  #update the alert status
                                      return render :json => {:success => "true", :message => "Alert is updated succesfully", :status => @alert_status, :distance => @asst_distance, :time => @time,:mystatus => @status} #return the response to api
                          else
                              return render :json => {:success => "false", :message => "Location information is incorrect", :status => "null", :distance => "", :time => ""}  #if invalid lat,lan
                          end
                 
                  else                 
                    return render :json => {:success => "false", :message => "Invalid alert id"}   #alert id is not found
                  end
            else
              @cancel = ServiceAlert.where('user_id= ?', params[:user_id]).update_all(status: "cancel")  #cancel all previous alerts corresponding to this user
               @alerts = ServiceAlert.create({
                :user_id=>params[:user_id],
                :service_center_id=>params[:service_center_id],
                :lan=>params[:lan],
                :lat=>params[:lat],
                :status=>"New"
              });
                if(@alerts.id !='' and @alerts.id !=nil)
                  @update = User.where('id= ?', params[:user_id]).update_all(lat: params[:lat], lan: params[:lan]) 
                   if(@update == 1)  
                     @current_distance = get_distance @user_loc,@center_loc     #hit the google api to get the diver location distance from service center
                        @distance_array =  @current_distance['routes'] 
                           if(@distance_array !='' and @current_distance['status'] !='ZERO_RESULTS' and @current_distance['status'] != 'NOT_FOUND' and @distance_array != nil)  #if no result is found from api
                              @distance_array.each do |distance| 
                                 @distance_count = distance['legs'] 
                                    @distance_count.each do |new_distance| 
                                      @distance =  new_distance['distance']['text'].gsub(/\s.+/, '').to_i   #lotal distance in kms
                                      @time = new_distance['duration']['text'] #total time 
                                      @asst_time = new_distance['duration']['text'].gsub(/\s.+/, '').to_i
                              end 
                            end

                            @service_status = ServiceAlert.where(:id => @alerts.id)    #get the current alert status
                            @service_status.each do |alert_status|
                              @alert_status = alert_status.status
                            end
                                 @status = ""
                                    if(@distance >= 1 and @alert_status == 'New')
                                      @status = "In Route"
                                    elsif(@distance < 1 and @alert_status == 'In Route')
                                      @status = "Service"
                                    elsif (@distance > 1 and @alert_status == 'Service')
                                      @status = "Complete"
                                    elsif (@distance < 1 and @alert_status == 'Service')
                                      @status = "Service"
                                    else
                                      @status = "In Route"
                                    end
                                    @update_alert = ServiceAlert.where('id= ?', @alerts.id).update_all(asstimate_time: @asst_time, asstimate_date: @asst_time )  #update the alert status
                                      return render :json => {:success => "true", :message => "New alert is created succesfully", :status => @status,:alert_id => @alerts.id, :distance => @distance, :time => @time,:mystatus => @status} #return the response to api
                          else
                              return render :json => {:success => "false", :message => "Location information is incorrect", :status => "null", :distance => "", :time => ""}  #if invalid lat,lan
                          end
                 
                  else                 
                    return render :json => {:success => "false", :message => "Invalid alert id"}   #alert id is not found
                  end
               else
                  return render :json => {:success => "false", :message => @alerts.errors}
                end
            end
        else
          return render :json => {:success => "false", :message => "User not exists or invalid service center id"}
        end
      else
        return render :json => {:success => "false", :message => "Missing perameters or invalid request method"}
    end
  end

  def get_distance user_loc,center_loc
    uri = "https://maps.googleapis.com/maps/api/directions/json?origin="+user_loc+"&destination="+center_loc+"&key=AIzaSyAiQZZcEjo_QUWj476y3FPeKbg94ZldZhw"
    request = Typhoeus::Request.new(uri,
    method: :get,
    #body: "this is a request body",
    #params: { field1: "a field" },
    headers: { Accept: "application/json" })
      request.run
      response = request.response
      #response.code
      return JSON.parse(response.response_body)
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
