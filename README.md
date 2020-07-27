# Seatify
 
Requirements: ruby, rspec


To load the files into irb:

```
load 'Allocator.rb'
load 'Labels.rb'
load 'Seats.rb'
load 'SeatAllocator.rb'
```

Usage:
Pass seat layout in the form of Lis[List] and number of passengers to ArrangeSeats.

A 2D array is returned with notation 'W3'-> window, 'A1' -> aisle 1 

Plain label like 'A', 'W' and 'M' are the empty seats.

0 signifies there are no seats in that area

```
as = ArrangeSeats.new([[1,2],[2,2]], 4)

as.seating_arrangement
```

Raises runtime expception when input format is incorrect.
