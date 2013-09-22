class ReservationsController < ApplicationController
  

  before_action :remember_restaurant 
 

  def new
    if Rails.env.development?
      @reservation = FactoryGirl.build(:reservation)
    else
    @reservation = Reservation.new
    end
  end

  def create
    @user = User.find(1) 
    @reservation = @restaurant.reservations.build(reservation_params)
    @reservation.user_id = @user.id  #whith sorcery add current_user.id
    # seats = @restaurant.seats 

    if restaurant_full
      # make_suggestions and return

      redirect_to restaurant_path(@restaurant), notice: "Sorry, your party cannot be seated at that time."
    else
      if @reservation.save
        date_display = @reservation.day.strftime("%A, %b %d")
        time_display = @reservation.meal_time.strftime("%I:%M %p")
        redirect_to restaurant_path(@restaurant), 
          notice: "You have made a reservation at #{@restaurant.name}
          for #{@reservation.party_size} people, on #{date_display} at #{time_display}" and return
      else
        render :new
      end
    end        
  end



  def index
    @reservations = Reservation.all
  end

  def show
    @reservation = Reservation.find(reservation_params)
  end

  private

  def remember_restaurant
     @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def restaurant_capacity_failure
      redirect_to restaurants_path, notice: "We are sorry, #{@restaurant.name} does not have sufficient capacity to accomodate your party."
  end


  def reservation_params
    params.require(:reservation).permit(:party_size, :time_slot, :date, :day, :meal_time)
  end

  def restaurant_full

    seats = @restaurant.seats    
    # if seats < @reservation.party_size
    #   return restaurant_capacity_failure
    #   # return redirect_to restaurants_path, notice: "We are sorry, #{@restaurant.name} does not have sufficient capacity to accomodate your party."
      
    # end  
    reserved_seats = 0 
    reservation_hour = @reservation.meal_time.hour
    reservation_minutes = @reservation.meal_time.min
    @bookings = []
    @bookings = @restaurant.reservations.where(:day => @reservation.day)
    return false if @bookings.empty?

    @bookings.each do |b| 
      conflict = false
      booking_hour = b.meal_time.hour
      booking_minutes = b.meal_time.min
      conflict = true if  booking_hour == reservation_hour
      conflict = true if (booking_hour == (reservation_hour + 1) && booking_minutes < reservation_minutes )    
      conflict = true if (booking_hour == (reservation_hour - 1) && booking_minutes > reservation_minutes )    
      reserved_seats = reserved_seats + b.party_size if conflict == true
    end
    vacant_seats = seats - reserved_seats
    if vacant_seats > @reservation.party_size
      return false
    else
      return true 
    end   
  end 


  def make_suggestions
    suggested_times = []
    find_next_quarter_hour(@reservation.meal_time)
    find_later_time(@new_time)
    suggested_times << @later_time
    find_earlier_time(@new_time)
    suggested_times << @earlier_time
    if suggested_times.empty?
      redirect_to restaurants_url, notice: "We are sorry, #{@restaurant.name} annot accomodate your party on #{@reservation.day}." and return
    else
      render :new, notice: "Sorry, your party cannot be seated at that time. We do have room at" and return 
      #{suggested_times.join(", or")}."
    end
  end

  def find_next_quarter_hour(old_time)
    #increases reservation time to the next higher quarter hour
    old_minutes = old_time.min
    reset_time = old_time - old_minutes.minutes
    if old_minutes > 15
      new_minutes = 15
    elsif old_minutes > 30
      new_minutes = 30
    elsif old_minutes > 45
      new_minutes = 45
    else 
      new_minutes = 60
    end
    
    @new_time = reset_time + new_minutes.minutes
    return @new_time
  end

   # def restaurant_hours
   #  @opening_time = @new_time.change(hour: @opening_hour)
   #  @closing_time = @new_time.change(hour: @closing_hour)
   # def 
    # end 

  def find_later_time(new_time)
    trial_time = new_time
    while trial_time.hour <= (20) #(closing_time - 1.hour)
      # time_available?(trial_time)
      if time_available?(trial_time)
        return @later_time = trial_time.strftime("%I:%M %p")
      else
        trial_time += 15.minutes
      end
    end
  end

  def find_earlier_time(new_time)
    trial_time = new_time - 15.minutes
    while trial_time.hour >= 11 #(opening_time)
     # time_available? (trial_time)
      if time_available?(trial_time)
        return @earlier_time = trial_time.strftime("%I:%M %p")
      else
        trial_time += 15.minutes
      end
    end
  end 


  

  def time_available?(time_input)

    seats = @restaurant.seats
    reserved_seats = 0 
    input_hour = time_input.hour
    input_minutes = time_input.min 
    #two duplicated lines below
    @bookings = []
    @bookings = @restaurant.reservations.where(:day => @reservation.day)

    @bookings.each do |b| 
      conflict = false
      booking_hour = b.meal_time.hour
      booking_minutes = b.meal_time.min
      conflict = true if  booking_hour == input_hour
      conflict = true if (booking_hour == (input_hour + 1) && booking_minutes < input_minutes )    
      conflict = true if (booking_hour == (input_hour - 1) && booking_minutes > input_minutes )    
      reserved_seats = reserved_seats + b.party_size if conflict == true
    end
    vacant_seats = seats - reserved_seats
    if vacant_seats > @reservation.party_size
      return true
    else
      return false 
    end   
  end 


end
