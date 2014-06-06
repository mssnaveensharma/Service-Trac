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
        else
          return render :json => {:success => false, :message => "invalid user id or service center not exists"}
        end
    else
      return render :json => {:success => false, :message => "required perameters are missing"}    
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
