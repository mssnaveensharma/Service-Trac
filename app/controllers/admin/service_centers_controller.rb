class Admin::ServiceCentersController < ApplicationController
  before_action :set_admin_service_center, only: [:show, :edit, :update, :destroy]
  before_filter :allow_admin_access, only: [:create, :edit, :update, :destroy,:new]
  before_action :authenticate, only: [:index]
  # GET /admin/service_centers
  # GET /admin/service_centers.json
  def index
    if(params[:lat] and params[:lan])
      arr = Array.new
      @admin_service_centers = Admin::ServiceCenter.all
      @admin_service_centers.each do |center|
      @user_loc = params[:lat]+","+params[:lan]
      @center_loc = center.lat+","+center.lan
      @current_distance = get_distance @user_loc,@center_loc     #hit the google api to get the diver location distance from service center
      @ratings = total_ratings center.id
                        @distance_array =  @current_distance['routes'] 
                           if(@distance_array !='' and @current_distance['status'] !='ZERO_RESULTS' and @current_distance['status'] != 'NOT_FOUND' and @distance_array != nil)  #if no result is found from api
                              @distance_array.each do |distance| 
                                 @distance_count = distance['legs'] 
                                    @distance_count.each do |new_distance| 
                                      @distance =  new_distance['distance']['text'].gsub(/\s.+/, '').to_i   #lotal distance in kms
                                      @time = new_distance['duration']['text'] #total time 
                                      response = Hash.new
                                      response[:Name]=center.Name
                                      response[:StreetAddress]=center.StreetAddress
                                      response[:State]=center.State
                                      response[:StateCode]=center.StateCode
                                      response[:City]=center.City
                                      response[:Pin]=center.Pin
                                      response[:Tel]=center.Tel
                                      response[:Fax]=center.Fax
                                      response[:Email]=center.Email
                                      response[:Url]=center.Url
                                      response[:lat]=center.lat
                                      response[:lan]=center.lan
                                      response[:ContactPerson]=center.ContactPerson
                                      response[:service_center_id]=center.id
                                      response[:distance]=@distance
                                      response[:time]=@time
                                      response[:reviews]=@ratings
                                      arr.push(response)
                              end 
                            end
               else
                    response = Hash.new
                    response[:Name]=center.Name
                    response[:StreetAddress]=center.StreetAddress
                    response[:State]=center.State
                    response[:StateCode]=center.StateCode
                    response[:City]=center.City
                    response[:Pin]=center.Pin
                    response[:Tel]=center.Tel
                    response[:Fax]=center.Fax
                    response[:Email]=center.Email
                    response[:Url]=center.Url
                    response[:lat]=center.lat
                    response[:lan]=center.lan
                    response[:ContactPerson]=center.ContactPerson
                    response[:service_center_id]=center.id
                    response[:distance]=""
                    response[:time]=""
                    response[:reviews]=@ratings
                    arr.push(response)
              end

      respond_to do |format|
          format.json {render :json => arr}   #return the json response to ajax
      end
    end
    else
       @admin_service_centers = Admin::ServiceCenter.all
    end
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

def total_ratings service_center_id
  @rate_one = ServiceCenterReview.where(:ratings => 1,:service_center_id => service_center_id)
  @rate_two = ServiceCenterReview.where(:ratings => 2,:service_center_id => service_center_id)
  @rate_three = ServiceCenterReview.where(:ratings => 3,:service_center_id => service_center_id)
  @rate_four = ServiceCenterReview.where(:ratings => 4,:service_center_id => service_center_id)
  @rate_five = ServiceCenterReview.where(:ratings => 5,:service_center_id => service_center_id)
  @total_count = ServiceCenterReview.where(:service_center_id => service_center_id)
    @one_star = @rate_one.length
    @two_star = @rate_two.length
    @three_star = @rate_three.length
    @four_star = @rate_four.length
    @five_star = @rate_five.length
    @total_star = @total_count.length
    @ratings = (5*@five_star + 4*@four_star + 3*@three_star + 2*@two_star + 1*@one_star) / @total_star
  return @ratings
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_service_center
      @admin_service_center = Admin::ServiceCenter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_service_center_params
      params.require(:admin_service_center).permit(:Name, :State, :StateCode, :City, :Pin, :Tel, :Fax, :Email, :Url, :ContactPerson, :lat, :lan, :StreetAddress)
    end
end
