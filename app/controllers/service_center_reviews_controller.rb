class ServiceCenterReviewsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_service_center_review, only: [:show, :edit, :update, :destroy]

  # GET /service_center_reviews
  # GET /service_center_reviews.json
  def index
    @service_center_reviews = ServiceCenterReview.all
  end

  # GET /service_center_reviews/1
  # GET /service_center_reviews/1.json
  def show
  end

  # GET /service_center_reviews/new
  def new
    @service_center_review = ServiceCenterReview.new
  end

  # GET /service_center_reviews/1/edit
  def edit
  end

  # POST /service_center_reviews
  # POST /service_center_reviews.json
  def create
    @service_center_review = ServiceCenterReview.new(service_center_review_params)

    respond_to do |format|
      if @service_center_review.save
        format.html { redirect_to @service_center_review, notice: 'Service center review was successfully created.' }
        format.json { render action: 'show', status: :created, location: @service_center_review }
      else
        format.html { render action: 'new' }
        format.json { render json: @service_center_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /service_center_reviews/1
  # PATCH/PUT /service_center_reviews/1.json
  def update
    respond_to do |format|
      if @service_center_review.update(service_center_review_params)
        format.html { redirect_to @service_center_review, notice: 'Service center review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @service_center_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_center_reviews/1
  # DELETE /service_center_reviews/1.json
  def destroy
    @service_center_review.destroy
    respond_to do |format|
      format.html { redirect_to service_center_reviews_url }
      format.json { head :no_content }
    end
  end

  def post_review
    if(params[:user_id] != '' and params[:service_center_id] != '' and params[:ratings] !='' and params[:comments] != '')
      @chk_user = User.where(:id => params[:user_id])
      @chk_center = Admin::ServiceCenter.where(:id => params[:service_center_id])
        if(@chk_center.length != 0 and @chk_user.length != 0)
          @ext_review = ServiceCenterReview.where(:service_center_id => params[:service_center_id], :user_id => params[:user_id])
            if(@ext_review.length != 0)
              @update = ServiceCenterReview.where('user_id = ? AND service_center_id = ?', params[:user_id],params[:service_center_id]).update_all(comments: params[:comments], ratings: params[:ratings]) 
                if(@update == 1)    
                  return render :json => {:success => "true", :message => "Review is updated successfully" }
                end
            else
              @reviews = ServiceCenterReview.create({
                        :user_id=>params[:user_id],
                        :service_center_id=>params[:service_center_id],
                        :comments=>params[:comments],
                        :ratings=>params[:ratings]
                      });
                      
                      if(@reviews.id !='' and @reviews.id !=nil)
                          return render :json => {:success => "true", :message => "Review is posted successfully", :review_id => @reviews.id }
                        else
                          return render :json => {:success => "false", :message => @reviews.errors}
                        end
            end
        else
          return render :json => {:success => false, :message => "invalid user id or service center not exists"}
        end
    else
      return render :json => {:success => false, :message => "required perameters are missing"}    
    end
  end

  def get_reviews
    if params[:service_center_id] != '' and params[:service_center_id] != nil
      service_center_reviews = Array.new
      @centers = ServiceCenterReview.where(:service_center_id => params[:service_center_id])
        if @centers.length != 0
           @centers.each do |center|
            @ratings = total_ratings center.service_center_id
            @comments = center.comments
            @date = center.created_at
              @user = User.where(:id => center.user_id)
                @user.each do |username|
                  @username = username.FirstName+" "+username.LastName
                end
              @center_name = Admin::ServiceCenter.where(:id =>params[:service_center_id])
                @center_name.each do |center_name|
                  @service_center = center_name.Name
                end
                response = Hash.new
                response[:date]=@date
                response[:username]=@username
                response[:ratings]=@ratings
                response[:comments]=@comments
                service_center_reviews.push(response)
          end
              return render :json => {:success => true,:service_center_reviews => service_center_reviews}  
        else
          return render :json => {:success => false, :message => "Service center currently has no reviews"}  
        end
      return render :json => {:success => false, :message => "required fields are missing"}
    else
      return render :json => {:success => false, :message => "required fields are missing"}
    end
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
    if(@total_star == 0)
      return 0
    else
      @ratings = (5*@five_star + 4*@four_star + 3*@three_star + 2*@two_star + 1*@one_star) / @total_star
    return @ratings
  end
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_center_review
      @service_center_review = ServiceCenterReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_center_review_params
      params[:service_center_review]
    end
end
