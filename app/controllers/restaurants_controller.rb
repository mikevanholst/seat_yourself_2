class RestaurantsController < ApplicationController

  def new
    if Rails.env.development?
      @restaurant = FactoryGirl.build(:restaurant_with_full_description)
    else
      @restaurant = Restaurant.new
    end
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save 
      redirect_to @restaurant, notice: "Restaurant successfully added." 
    else
      render :new
    end  
  end


  def index
    @restaurants = Restaurant.all
  end

  def show
   load_restaurant
    @reservation = Reservation.new
  end

  def edit
    load_restaurant
  end

  def update
    load_restaurant
    if @restaurant.update_attributes(restaurant_params)
      redirect_to @restaurant, notice: "Successfully updated!"
    else
      render :new
    end  
  end


  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :phone, :price_range, :address, :seats, :category, :neighbourhood)  
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:id])    
  end

end
