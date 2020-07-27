class ArrangeSeats 
    attr_reader :seat_structure, :passenger_count, :window_seats, :middle_seats, :aisle_seats
    
    def initialize (seat_structure, no_of_passengers)
        if seat_structure.nil? or seat_structure.empty? == 0
            puts 'Pass a valid seat_structure'
            return
        end
        @window_seats = 0
        @aisle_seats = 0
        @middle_seats = 0
        @passenger_count = no_of_passengers
        @seat_structure = seat_structure
    end

    def seating_arrangement
        @seating_arrangement.each { |row|
            puts row.join(" ")
           }
    end

    def add_seats(rows, cols, window = false)
        if window == true
            @window_seats += rows
            cols -= 1

            if cols > 0 
                @aisle_seats += rows
                cols -= 1
            end
        else
            if cols >= 2
                @aisle_seats += (rows * 2)
                cols -= 2
            elsif cols == 1
                @aisle_seats += rows
                cols -= 1   
            end         
        end
        @middle_seats += (rows * cols)        
    end

    def add_label(label, rows, column)
        for row in 0..rows-1 do 
            @seating_arrangement[row][column] = label
        end
    end

    def add_labels(rows, col_start, col_end, window=false, left=false)
        if window == true
            if left == true
                add_label('A', rows, col_end)
                add_label('W', rows, col_start)                
            else
                add_label('A', rows, col_start)
                add_label('W', rows, col_end)                
            end
        else
            add_label('A', rows, col_start)
            add_label('A', rows, col_end)
        end
        for col in col_start+1..col_end-1 do
            add_label('M', rown, col)
        end
    end

    def generate_base_seating_arrangement
        rows = 0
        columns = 0
        index = 0

        while index < @seat_structure.length do
            columns = columns + @seat_structure[index][1]
            if @seat_structure[index][0] > rows
                rows = @seat_structure[index][0]
            end

            if index == 0 or index == @seat_structure.length-1
                add_seats(@seat_structure[index][0], @seat_structure[index][1], true)
            else
                add_seats(@seat_structure[index][0], @seat_structure[index][1],)
            end
            index += 1            
        end

        @seating_arrangement = Array.new(rows) { Array.new(columns)}        

        index = 0
        cols = 0

        @seat_structure.each do | segment |
            if index == 0                 
                add_labels( segment[0], cols, cols +segment[1] - 1,  true, true)
            elsif index == @seat_structure.length-1
                add_labels( @seat_structure[index][0], cols, cols + @seat_structure[index][1] - 1,  true, false)
            else
                add_labels( @seat_structure[index][0], cols, cols + @seat_structure[index][1] - 1)
            end
            cols += @seat_structure[index][1]              
            index += 1
        end
    end
    
    def add_seat_numbers
        remaining_passenger_count = @passenger_count
        
        if remaining_passenger_count > 0 and @aisle_seats <= remaining_passenger_count
            aisle_passengers = @aisle_seats
        else
            aisle_passengers = remaining_passenger_count
        end
        remaining_passenger_count -= aisle_passengers
        
        if remaining_passenger_count > 0 and @window_seats <= remaining_passenger_count
            window_passengers = @window_seats
        elsif remaining_passenger_count > 0 and @window_seats > remaining_passenger_count
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
         
        window_filled = 0
        middle_filled = 0
        aisle_filled = 0
        rows = 0
        @seating_arrangement.each do |row|
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
                @seating_arrangement[rows][cols] = seat
                cols += 1
            end
            rows += 1        
        end
    end
end