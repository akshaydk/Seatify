class Labels
    def initialize(seats, seats_layout)
        @seats = seats
        @seats_layout = seats_layout
    end
        
    def add_label(label, rows, column )
        for row in 0..rows-1 do 
            @seats[row][column] = label
        end
    end

    def add_labels(rows, col_start, col_end, window=false, left=false )
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

    def add
        index = cols = 0
        @seats_layout.each do | segment |
            if index == 0                 
                add_labels( segment[0], cols, cols + segment[1] - 1,  true, true )
            elsif index == @seats_layout.length-1
                add_labels( @seats_layout[index][0], cols, cols + @seats_layout[index][1] - 1,  true, false )
            else
                add_labels( @seats_layout[index][0], cols, cols + @seats_layout[index][1] - 1 )
            end
            cols += @seats_layout[index][1]              
            index += 1
        end
        return @seats
    end
end
