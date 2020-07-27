class Allocator
    def initialize(seats, passengers)
        @seats = seats
        @passengers = passengers
    end

    def calculate_seat_count
        window_seats = aisle_seats = total = 0
        for row in @seats
            for seat in row
                if seat != 0
                    total += 1
                end
                if seat == 'W' 
                    window_seats += 1
                elsif seat == 'A'
                    aisle_seats += 1
                end
            end
        end
        return [window_seats, aisle_seats, total]        
    end

    def allocate
        window_seats, aisle_seats, total = calculate_seat_count 
        if total < @passengers
            raise 'Cannot find seats for all passengers'
        end
        remaining_passenger_count = @passengers       
        if  remaining_passenger_count > 0 and aisle_seats <= remaining_passenger_count
            aisle_passengers = aisle_seats
        else
            aisle_passengers = remaining_passenger_count
        end
        remaining_passenger_count -= aisle_passengers
        
        if remaining_passenger_count > 0 and window_seats <= remaining_passenger_count
            window_passengers = window_seats
        elsif remaining_passenger_count > 0 and window_seats > remaining_passenger_count
            window_passengers = remaining_passenger_count
        else
            window_passengers = 0
        end
        remaining_passenger_count -= window_passengers

        if remaining_passenger_count > 0
            middle_passeengers = remaining_passenger_count
        else
            middle_passeengers = 0
        end
        
        window_filled = middle_filled = aisle_filled = rows = 0
        @seats.each do |row|
            cols = 0
            row.each do |seat|
                if seat == 'W' and window_filled < window_passengers
                    seat += String( aisle_passengers + window_filled + 1)
                    window_filled += 1
                elsif seat == 'A' and aisle_filled < aisle_passengers
                    seat += String( aisle_filled + 1 )
                    aisle_filled += 1
                elsif seat == 'M' and middle_filled < middle_passeengers
                    seat += String( aisle_passengers + window_passengers + middle_filled + 1)
                    middle_filled += 1
                end
                @seats[rows][cols] = seat
                cols += 1
            end
            rows += 1        
        end
        return @seats
    end
end