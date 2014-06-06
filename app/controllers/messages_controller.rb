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
    @users = User.all
      arr = Array.new
       @users.each do |user| 
           @messages.each do |message| 
               if(message.FromUserId == user.id or message.ToUserId == user.id) 
                  response = Hash.new
                  response[:id]=message.id
                  response[:date]=message.created_at
                  response[:name]=user.FirstName
                  response[:content]=message.MessageContent
                  arr.push(response)
               
           end 
       end 
       end
      @new_users = arr
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
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
      @chk_to_user = User.where(:id => params[:ToUserId])
        if(@chk_from_user.length !=0 and @chk_to_user.length !=0 )
           @message = Message.create({
                    :ToUserId=>params[:ToUserId],
                    :FromUserId=>params[:FromUserId],
                    :MessageContent=>params[:MessageContent]});
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
      params.require(:message).permit(:FromUserId, :ToUserId, :MessageContent)
    end
end
