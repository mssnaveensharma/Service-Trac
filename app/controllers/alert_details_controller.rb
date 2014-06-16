class AlertDetailsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_alert_detail, only: [:show, :edit, :update, :destroy]

  #before_action :authenticate, only: [:get_route]

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
          @asst_time = Time.now + alert.asstimate_time.to_i.hours
          #@asst_date = 
          @center_location = Admin::ServiceCenter.where(:id => alert.service_center_id)
            @users = User.where(:id => alert.user_id)
              @users.each do |user|
                @contact = user.Contact
                @eobr_number = user.EobrNumber
                @truck_year = user.TruckYear
                @truck_make = user.TruckMake
                @tech_support = user.tech_support_id
                if @tech_support != 0
                  @tech_support_call = "Yes"
                else
                  @tech_support_call = "No"
                end
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
                  response[:service_center]=center.Name
                  response[:service_center_id]=center.id
                  response[:ticket_ref_no]=alert.ticket_ref_no
                  response[:ticket_po_no]=alert.ticket_po_no
                  response[:city_state]=center.City+"/"+center.State
                  response[:last_alert]=alert.created_at.strftime("%d/%m/%y")
                  response[:asst_time]=@asst_time.strftime("%I:%M %p")
                  response[:asst_date]=Date.today.strftime("%d/%m/%y")
                  response[:alert_status]=alert.status
                  response[:tech_called]=@tech_support_call
                  data.push(response)
                end
        end
      return render :json =>  data
    else
      return render :json => {:success => false, :data => "Required fields are missing "}     
    end
  end

  def edit_alert
    @eobr_makes = Admin::EobrMake.all
    @eobr_models = Admin::EobrModel.all
    @tech_supports = Admin::TechSupport.all
  end

  def update_alert
    @id = params[:id]
    
    if (params[:id] and params[:id] !='' and params[:user_id] and params[:user_id] !='' and params[:Contact] and params[:Contact] !='' and params[:TruckYear] and params[:TruckYear] !='' and params[:TruckMake] and params[:TruckMake] !='' and params[:eobr_make_id] and params[:eobr_make_id] !='' and params[:eobr_model_id] !='' and params[:eobr_model_id] !=nil and params[:EobrNumber] and [:EobrNumber] !='' and params[:tech_support_id] and params[:tech_support_id] !='')
      @update = User.where(:id => params[:user_id]).update_all(Contact: params[:Contact], TruckYear: params[:TruckYear], TruckMake: params[:TruckMake], eobr_make_id: params[:eobr_make_id], eobr_model_id: params[:eobr_model_id], EobrNumber: params[:EobrNumber], tech_support_id: params[:tech_support_id])
        if(@update == 1)
          respond_to do |format|
              format.html { redirect_to '/alert_details?id='+@id, notice: 'Alert is updated successfully' }
              format.json { render json: @update.errors, status: :unprocessable_entity }
          end
        else
          respond_to do |format|
              format.html { redirect_to '/edit_alert?id='+@id, notice: 'Required fields are missing' }
              format.json { render json: @update.errors, status: :unprocessable_entity }
          end
        end
            
      else
        respond_to do |format|
          format.html { redirect_to '/edit_alert?id='+@id, notice: 'Required fields are missing' }
          format.json { render json: @update.errors, status: :unprocessable_entity }
        end
      end
  end

  def edit_service_center
  end

  def update_service_center
    @id = params[:id]
    @alert = params[:alert_id]
    if params[:id] and params[:id] != '' and params[:Name] and params[:Name] != '' and params[:State] and params[:State] != '' and params[:StreetAddress] and params[:StreetAddress] != '' and params[:StateCode] and params[:StateCode] != '' and params[:City] and params[:City] != '' and params[:Pin] and params[:Pin] != '' and params[:Tel] and params[:Tel] != '' and params[:Fax] and params[:Fax] != '' and params[:Email] and params[:Email] != '' and params[:Url] and params[:Url] != '' and params[:ContactPerson] and params[:ContactPerson] != '' and params[:lat] and params[:lan] != ''
      @update = Admin::ServiceCenter.where(:id => params[:id]).update_all(Name: params[:Name], State: params[:State], StreetAddress: params[:StreetAddress], StateCode: params[:StateCode], City: params[:City], Pin: params[:Pin], Tel: params[:Tel], Fax: params[:Fax], Email: params[:Email], Url: params[:Url], ContactPerson: params[:ContactPerson], lat: params[:lat], lan: params[:lan])
        if @update == 1
          respond_to do |format|
              format.html { redirect_to '/alert_details?id='+@alert, notice: 'Service center updated successfully' }
              format.json { render json: @update.errors, status: :unprocessable_entity }
          end
        else
          respond_to do |format|
              format.html { redirect_to '/edit_service_center?id='+@id, notice: 'Service center is not updated' }
              format.json { render json: @update.errors, status: :unprocessable_entity }
          end
        end
    else
      respond_to do |format|
          format.html { redirect_to '/edit_service_center?id='+@id, notice: 'Required fields are missing' }
          format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  def service_ticket
  end

  def update_ticket
    @id = params[:id]
    if params[:id] and params[:id] != '' and params[:ticket_po_no] and params[:ticket_po_no] != '' and params[:ticket_ref_no] and params[:ticket_ref_no] != ''
      @update = ServiceAlert.where(:id => params[:id]).update_all(ticket_po_no: params[:ticket_po_no], ticket_ref_no: params[:ticket_ref_no])
        if @update == 1
          respond_to do |format|
            format.html { redirect_to '/alert_details?id='+@id, notice: 'Service ticket is updated succesfully' }
            format.json { render json: @update.errors, status: :unprocessable_entity }
          end          
        else
          respond_to do |format|
            format.html { redirect_to '/service_ticket?id='+@id, notice: 'Service ticket is not updated' }
            format.json { render json: @update.errors, status: :unprocessable_entity }
          end          
        end
    else
        respond_to do |format|
          format.html { redirect_to '/service_ticket?id='+@id, notice: 'Required fields are missing' }
          format.json { render json: @update.errors, status: :unprocessable_entity }
        end
    end
  end

  def add_notes
    if params[:user_id] and params[:user_id] !='' and params[:description] and params[:description] != '' and params[:alert_id] and params[:alert_id] !=''
      @chk_user = User.where(:id => params[:user_id])
      @chk_alert = ServiceAlert.where(:id => params[:alert_id])
      if @chk_user.length !=0 and @chk_alert !=0
          if params[:sent_by] and params[:sent_by]=="WebUser"
            @sentBy = "WebUser"
          else
            @sentBy = "AppUser"
          end
            @create = AlertNotes.create({
                :user_id =>params[:user_id],
                :alert_id =>params[:alert_id],
                :description => params[:description],
                :sent_by => @sentBy
              });

              if @create.id != '' and @create.id != nil
                return render :json => {:success => true, :message => "Note was added successfully", :note_id => @create.id}      
              else
                return render :json => {:success => false, :message => @create.errors}
              end
      else
        return render :json => {:success => false, :message => "User not exists or invalid alert id"}
      end
    else
      return render :json => {:success => false, :message => "Required perameters are missing"}
    end
  end

  def get_notes
    if params[:alert_id] and params[:alert_id] != ''
      notesArray = Array.new
      @notes = AlertNotes.where(:alert_id => params[:alert_id]).limit(3)
      if @notes.length != 0
          @notes.each do |note|
            response = Hash.new
            response[:created_at]=note.created_at.strftime("%d/%m/%y %I:%M %p")
            response[:description]=note.description
            notesArray.push(response)
          end
        return render :json => {:success => true, :notes => notesArray}
      else
        return render :json => {:success => false, :message => "Currently the service haven't the notes"}
      end
    else
      return render :json => {:success => false, :message => "Alert id is required"}
    end
  end

def notes
end

def add_notes_web
@alert =params[:alert_id]
    if params[:user_id] and params[:user_id] !='' and params[:description] and params[:description] != '' and params[:alert_id] and params[:alert_id] !=''
      @chk_user = User.where(:id => params[:user_id])
      @chk_alert = ServiceAlert.where(:id => params[:alert_id])
      if @chk_user.length !=0 and @chk_alert !=0
          if params[:sent_by] and params[:sent_by]=="WebUser"
            @sentBy = "WebUser"
          else
            @sentBy = "AppUser"
          end
            @create = AlertNotes.create({
                :user_id =>params[:user_id],
                :alert_id =>params[:alert_id],
                :description => params[:description],
                :sent_by => @sentBy
              });

          respond_to do |format|
              if @create.id != '' and @create.id != nil
                format.html { redirect_to '/alert_details?id='+@alert, notice: 'Alert was updated successfully' }
                #format.json { render json: @update.errors, status: :unprocessable_entity }
              else
                 format.html { redirect_to '/notes?alert='+@alert, notice: 'Notes was not added' }
                 format.json { render json: @update.errors, status: :unprocessable_entity }
              end
          end
      else
        return render :json => {:success => false, :message => "User not exists or invalid alert id"}
      end
    else
      return render :json => {:success => false, :message => "Required perameters are missing"}
    end
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
