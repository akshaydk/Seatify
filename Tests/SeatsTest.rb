require 'rspec/autorun'
require_relative './../Seats.rb'

describe Seats do
    it 'will generate a default matrix when seats_layout is given' do
        seats = Seats.new([[1,2],[2,2]])
        expect(seats.to_array).to eq([[ 0,0,0,0 ],[ 0,0,0,0 ]])

        seats = Seats.new([[1,1],[1,1]])
        expect(seats.to_array).to eq([[0,0]])
    end

    it 'will raise and excpetion if the seats_layout is not the expected format' do
        seats = Seats.new([[2,2,1]])
        expect { seats.to_array }.to raise_error(RuntimeError)

        seats = Seats.new([[1]])
        expect { seats.to_array }.to raise_error(RuntimeError)
    end
end