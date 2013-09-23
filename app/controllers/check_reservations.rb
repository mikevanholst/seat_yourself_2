def check_reservations
  seats = @restaurant.seats 

#determine if the restaurant is big enough
  if seats < @reservation.party_size
      return "restaurant_capacity_failure"
  end

# if there are no reservations yet then book the party
  @bookings = []
  @bookings = @restaurant.reservations.where(:day => @reservation.day)
  if @bookings.empty?
    return "tables_available"
  end
    
# fetch the reservation time 
  reservation_hour = @reservation.meal_time.hour
  reservation_minutes = @reservation.meal_time.min

#find out how many seats have been booked within an hour of the resrevation  
  reserved_seats = 0 
  @bookings.each do |b| 
    conflict = false
    booking_hour = b.meal_time.hour
    booking_minutes = b.meal_time.min
    conflict = true if  booking_hour == reservation_hour
    conflict = true if (booking_hour == (reservation_hour + 1) && booking_minutes < reservation_minutes )    
    conflict = true if (booking_hour == (reservation_hour - 1) && booking_minutes > reservation_minutes )    
    reserved_seats = reserved_seats + b.party_size if conflict == true
  end

# find out the number of vacant seats at reservation time  
  vacant_seats = seats - reserved_seats

# determine if there are enough seats available for the party.  
  if vacant_seats > @reservation.party_size
    return "tables_available"
  end 

# try to find an available reservation time later and earlier in the day.
   @suggested_times = []

# bump the reservation time up to the next quarter hour
  find_next_quarter_hour(@reservation.meal_time)

# look for a later time and add it to suggested times
    find_later_time(@new_time)
    @suggested_times << @later_time

 # look for a later time and add it to suggested times   
    find_earlier_time(@new_time)
    @suggested_times << @earlier_time

# forward recomendations or apologize if the restaurant is booked for the day    
    if suggested_times.empty?
      return "completely_booked"
    else
      return "suggestions"
    end

end



