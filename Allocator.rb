class Allocator
    def initialize(seats, passengers)
        @seats = seats
        @passengers = passengers
        @total = 0
    end

    def calculate_seat_count
        window_seats = aisle_seats = 0
        for row in @seats
            for seat in row
                if seat != 0
                    @total += 1
                end
                if seat == 'W' 
                    window_seats += 1
                elsif seat == 'A'
                    aisle_seats += 1
                end
            end
        end
        return [window_seats, aisle_seats]        
    end

    def isFlightOverload()
        return @total < @passengers
    end

    def calculate_aisle_passengers(aisle_seats, remaining_passengers)
        (remaining_passengers > 0 and aisle_seats <= remaining_passengers) ? aisle_seats : remaining_passengers
    end

    def calculate_window_passengers(window_seats, remaining_passengers)
        if remaining_passengers > 0 and window_seats <= remaining_passengers
            return window_seats
        elsif remaining_passengers > 0 and window_seats > remaining_passengers
            return remaining_passengers
        else
            return 0
        end
    end

    def calculate_middle_passengers(remaining_passengers)
        remaining_passengers > 0 ? remaining_passengers : 0
    end

    def allocate
        window_seats, aisle_seats = calculate_seat_count 

        if isFlightOverload() 
             raise 'Cannot find seats for all passenger' 
        end
        remaining_passengers = @passengers
        aisle_passengers = calculate_aisle_passengers(aisle_seats, remaining_passengers)
        remaining_passengers -= aisle_passengers
        
        window_passengers = calculate_window_passengers(window_seats, remaining_passengers)
        remaining_passengers -= window_passengers

        middle_passeengers = calculate_middle_passengers(remaining_passengers)
        
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