class SeatAllocator 
    attr_reader :seating_arrangement
    
    def initialize seats_layout, passengers
        
        if seats_layout.nil? or seats_layout.empty? or passengers == 0
            raise 'Dont disturb me unless you have some passengers to be seated!' 
        end
        
        @passengers = passengers
        @seats = Seats.new(seats_layout).to_array
        @labled_seats = Labels.new(@seats, seats_layout).add               
    end

    def allocate()
        @seating_arrangement = Allocator.new(@labled_seats, @passengers).allocate
        @seating_arrangement    
    end
end