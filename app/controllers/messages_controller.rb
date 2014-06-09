class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:index,:post_message]
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.find(:all, :order => "created_at DESC")
    @messages_l = @messages.length
    @message = Message.new
    @users = User.where(:Role => "AppUser")
    @service_centers = Admin::ServiceCenter.all
      arr = Array.new
         @messages.each do |message| 
            @service_centers.each do |center|
              @users.each do |user|
                if message.ToUserId == user.id 
                  @name = user.FirstName
                  @truck = user.TruckNumber
                      response = Hash.new
                      response[:id]=message.id
                      response[:truck]=@truck
                      response[:date]=message.created_at
                      response[:name]=@name
                      response[:content]=message.MessageContent
                      arr.push(response)
                elsif message.FromUserId == user.id
                  @name = user.FirstName
                  @truck = user.TruckNumber
                      response = Hash.new
                      response[:id]=message.id
                      response[:truck]=@truck
                      response[:date]=message.created_at
                      response[:name]=@name
                      response[:content]=message.MessageContent
                      arr.push(response)
                end
              end
            end  
         end
         @new_users = arr.uniq{|x| x[:id]}

  end

  # GET /messages/1
  # GET /messages/1.json
  def show

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
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { head :no_content }
       else
        format.html { render action: 'new' }
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
      @chk_center = Admin::ServiceCenter.where(:id => params[:ToUserId])
        if(@chk_from_user.length !=0 and @chk_center.length !=0 )
           @message = Message.create({
                    :ToUserId=>params[:ToUserId],
                    :FromUserId=>params[:FromUserId],
                    :MessageContent=>params[:MessageContent],
                    :sent_by=>"AppUser" });
            if(@message.id !='' and @message.id != nil)
              return render :json => {:success => "true", :message => "Message is posted successfully", :meesage_id => @message.id}
            else
              return render :json => {:success => "false", :message => @message.errors}     
            end
         else
          return render :json => {:success => "false", :message => "Invalid user id or service center not exists"} 
         end
      #return render :json => {:success => "false", :message => "Method is working fine"} 
    else
      return render :json => {:success => "false", :message => "Required fields are missing"} 
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:FromUserId, :ToUserId, :MessageContent, :sent_by)
    end
end
