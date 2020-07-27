class Seats
    def initialize(seats_layout)
        @seats_layout = seats_layout
    end

    def check(array)
        if array.length != 2 then
            raise 'Improper input format'
        end
    end

    def to_array
        rows = index = columns = 0
        while index < @seats_layout.length do 
            check(@seats_layout[index])               
            columns = columns + @seats_layout[index][1]                
            if @seats_layout[index][0] > rows
                rows = @seats_layout[index][0]
            end                
            index += 1            
        end 
        return Array.new( rows, 0 ) { Array.new( columns, 0 )}   
    end
end