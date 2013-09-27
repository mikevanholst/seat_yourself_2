class ReviewsController < ApplicationController

  before_action :remember_restaurant 

  def new

    if Rails.env.development?
      @review = FactoryGirl.build(:review)
    else
      @review = Review.new
    end
  end

  def create

    # @review = Review.new(review_params)  ok but has no restaurant associated
    #@review.restaurant_id = @restaurant.id or params[:restaurant_id]
    @review = @restaurant.reviews.build(review_params)
    @review.user_id = 1 #current_user.id 

    respond_to  do |format|
      if @review.save
        format.html { redirect_to @review.restaurant, notice: "Thank you for adding a review." }
        format.js {}
      else
        format.html {render action: :show}
        format.js {}
      end  
    end
  end


  def show
    #remember_restaurant
  end


  private

  def remember_restaurant
     @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def review_params
    params.require(:review).permit(:content)  
  end

end
