class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:index,:post_message]
  # GET /messages
  # GET /messages.json
  def index
    
    @message = Message.new
    if current_user.Role == "admin"
      @users = User.all
    else
      @company = UsersServiceCenter.where(:user_id => current_user.id)
      @company.each do |c|
        @company_id = c.company_id
      end
      @users = User.where(:company_id => @company_id)
    end
      arr = Array.new
          @users.each do |user|
            @messages = Message.where('FromUserId = ? or ToUserId = ?', user.id, user.id).order('created_at DESC').limit(1)
            @messages.each do |message| 
                  @name = user.FirstName
                  @truck = user.TruckNumber
                  if user.Role == "AppUser"
                      response = Hash.new
                      response[:id]=message.id
                      response[:from]=message.FromUserId
                      response[:to]=message.ToUserId
                      response[:truck]=@truck
                      response[:date]=message.created_at.strftime("%d/%m/%y %I:%M %p")
                      response[:name]=@name
                      response[:content]=message.MessageContent
                      response[:user_id]=user.id
                      arr.push(response)
                  end
              end
         end
         @new_users = arr.uniq{|x| x[:id]}

  end

  # GET /messages/1
  # GET /messages/1.json
  def show

  Urbanairship.application_key = 'mkmnPV4XT9OQF6afE2Ac2A'
  Urbanairship.application_secret = 'TE_V6elVQ9qdI3KlG6bkBw'
  Urbanairship.master_secret = 'ZjNzdvofSPOiXdYEfssBvQ'
  Urbanairship.logger = Rails.logger
  Urbanairship.request_timeout = 5 # default
    

     @users = User.all
     @user = User.find(@message.ToUserId) 
     @d_type = @user.device_type 
     @d_token = @user.device_token 
     @user_msg = @message.MessageContent 
    
     if @d_type == 'iphone' 
     Urbanairship.register_device(@d_token)
     notification = { 
       :schedule_for => [1.second.from_now],  
       :device_tokens => [@d_token], 
       :aps => {:alert => @user_msg, :badge => 1} 
       } 
      @response = Urbanairship.push(notification) 
      
       else @d_type == 'wp' 
       @url = @user.wp_notification_url 
        uri = @url
        #@user_msg = "Service alert notification"
        options = {
            title: "Servicetrac alert notification",
            content: @user_msg,
            params: {
                any_data: 2,
                another_key: "Hum..."
            }
        }

    # response is an Net::HTTP object
    @reponse = MicrosoftPushNotificationService.send_notification uri, :toast, options
     end 
    #notification = {
    #:schedule_for => [1.second.from_now],
    #:device_tokens => ['7d84912fd8b2d7318ef2d04529fc87f71a28ca82f2c15e2e5267c0e13dc25b80'],
    #:aps => {:alert => 'bnde hai hum uske..hmpe kiska jor..', :badge => 1}
  #}
  #Urbanairship.push(notification)
  end

  # GET /messages/new
  def new
    @message = Message.new
    @users = User.all
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    respond_to do |format|
     if @message.save
      Urbanairship.application_key = 'mkmnPV4XT9OQF6afE2Ac2A'
      Urbanairship.application_secret = 'TE_V6elVQ9qdI3KlG6bkBw'
      Urbanairship.master_secret = 'ZjNzdvofSPOiXdYEfssBvQ'
      Urbanairship.logger = Rails.logger
      Urbanairship.request_timeout = 5 # default
      @users = User.all
       @user = User.find(@message.ToUserId) 
       @d_type = @user.device_type 
       @d_token = @user.device_token 
       @user_msg = @message.MessageContent 
    
     if @d_type == 'iphone' 
     Urbanairship.register_device(@d_token)
     notification = { 
       :device_tokens => [@d_token], 
       :aps => {:alert => @user_msg, :badge => 1} 
       } 
      @response = Urbanairship.push(notification) 
      
       else @d_type == 'wp' 
       @uri = @user.wp_notification_url 
        #@uri = "http://dm2.notify.live.net/throttledthirdparty/01.00/AQG1so170LoxTLZaBni2ZC30AgAAAAADAQAAAAQUZm52OkJCMjg1QTg1QkZDMkUxREQFBlVTTkMwMQ"
        #@user_msg = "Service alert notification"
        options = {
            title: "Servicetrac alert notification",
            content: @user_msg,
            params: {
                any_data: 2,
                another_key: "Servicetrac alert notification"
            }
        }

    # response is an Net::HTTP object
    @reponse = MicrosoftPushNotificationService.send_notification @uri, :toast, options
     end 
    #notification = {
    #:schedule_for => [1.second.from_now],
    #:device_tokens => ['7d84912fd8b2d7318ef2d04529fc87f71a28ca82f2c15e2e5267c0e13dc25b80'],
    #:aps => {:alert => 'bnde hai hum uske..hmpe kiska jor..', :badge => 1}
  #}
  #Urbanairship.push(notification)
        format.html { redirect_to '/messages', notice: 'Message was send successfully.' }
        format.json { head :no_content }
       else
        format.html { redirect_to '/messages', notice: 'Required fields are missing' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end


  def post_message
    if(params[:ToUserId] != '' and params[:FromUserId] != '' and params[:MessageContent] !='')
      @chk_from_user = User.where(:id => params[:FromUserId])
      @chk_center = Admin::Company.where(:id => params[:ToUserId])
        if(@chk_from_user.length !=0 and @chk_center.length !=0 )
           @message = Message.create({
                    :ToUserId=>params[:ToUserId],
                    :FromUserId=>params[:FromUserId],
                    :MessageContent=>params[:MessageContent],
                    :service_center_id=>params[:ToUserId],
                    :sent_by=>"AppUser" });
            if(@message.id !='' and @message.id != nil)
              return render :json => {:success => "true", :message => "Message is posted successfully", :meesage_id => @message.id}
            else
              return render :json => {:success => "false", :message => @message.errors}     
            end
         else
          return render :json => {:success => "false", :message => "Invalid user id or company not exists"} 
         end
      #return render :json => {:success => "false", :message => "Method is working fine"} 
    else
      return render :json => {:success => "false", :message => "Required fields are missing"} 
    end
  end

def all_messages
  if params[:user_id] != '' and params[:user_id] != nil and params[:company_id] and params[:company_id] != nil
   messages = Array.new
    @messages = Message.where('FromUserId = ? or ToUserId = ?', params[:user_id], params[:user_id])
      if @messages.length != 0
        @users = User.where(:id => params[:user_id])
        @users.each do |user|
          @user_name = user.FirstName
        end
        @messages.each do |message| 

            @companies = Admin::Company.where(:id => params[:company_id])
                @companies.each do |c|
                  @c_name = c.CompanyName
                  #@center_id = center.id
            end


                if message.service_center_id.to_i == params[:company_id].to_i
                    response = Hash.new
                    response[:date]=message.created_at.strftime("%d/%m/%y %I:%M %p")
                    response[:service_center]=@service_center
                    response[:message]=message.MessageContent
                    response[:messageId]=message.id
                    response[:username]=@user_name
                    response[:sent_by]=message.sent_by
                    response[:companyName]=@c_name
                    #response[:service_center_id]=message.service_center_id
                    #response[:my_Service]=params[:service_center_id]
                    messages.push(response)
              @messageArray = messages
            end
        end
          if @messageArray !="" and @messageArray != nil
            return render :json => {:success => true, :messages => @messageArray}
          else
            return render :json => {:success => false, :message => 'no messages for this user'}
          end
      else
        return render :json => {:success => false, :message => 'no messages for this user'}
      end
  else
    return render :json => {:success => false, :messages => 'User id is required'}
  end
end

def get_messages
  if params[:user_id] and params[:user_id] != ''
    arr = Array.new
      @messages = Message.where('FromUserId = ? or ToUserId = ?', params[:user_id], params[:user_id]).order("created_at DESC")
        if @messages.length != 0
            @users = User.where(:id => params[:user_id])
              @users.each do |user|
                @name = user.FirstName
                @truck = user.TruckNumber
                @userid = user.id
                @role = user.Role
              end
              if @role == "AppUser"
                @messages.each do |message|
                  response = Hash.new
                  response[:id]=message.id
                  #response[:from]=message.FromUserId
                  #response[:to]=message.ToUserId
                  response[:truck]=@truck
                  response[:date]=message.created_at.strftime("%d/%m/%y %I:%M %p")
                  response[:name]=@name
                  response[:content]=message.MessageContent
                  response[:user_id]=@userid
                  arr.push(response)
                end
              end
              @AllMessages = arr.uniq{|x| x[:id]}
              return render :json => {:success => true, :messages => @AllMessages }
        else
          return render :json => {:success => false, :messages => 'No messages for this user'}
        end
  else
    return render :json => {:success => false, :messages => 'User id required'}
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:FromUserId, :ToUserId, :MessageContent, :sent_by, :service_center_id)
    end
end
