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
    @review = Review.new(review_params)   
    @review.user_id = 1 #current_user.id 

    if @review.save
      redirect_to restaurant_path(:restaurant_id), notice: "Thank you for adding a review."
    else
      render action: :show
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
