require 'rspec/autorun'
require_relative './../ArrangeSeats.rb'
require_relative './../Seats.rb'
require_relative './../Labels.rb'
require_relative './../Allocator.rb'

describe 'ArrangeSeats' do
    it 'will return an array with seating allocation' do
        allow_any_instance_of(Seats).to receive(:new).and_return([[ 0,0,0,0 ],[ 0,0,0,0]])
        allow_any_instance_of(Labels).to receive(:new).and_return([["W", "A", "A", "W"], [0, 0, "A", "W"]])
        allow_any_instance_of(Allocator).to receive(:new).and_return([["W4", "A1", "A2", "W"], [0, 0, "A3", "W"]])

        sa = ArrangeSeats.new([[1,2],[2,2]], 4)
        expect(sa.seating_arrangement).to eq([["W4", "A1", "A2", "W"], [0, 0, "A3", "W"]])
    end

    it 'will not accept if passenger count is 0' do
        expect{ArrangeSeats.new([[1,2],[2,2]], 0)}.to raise_error(RuntimeError)
    end

    it 'will not accept if layout is empty' do
        expect{ArrangeSeats.new([], 1)}.to raise_error(RuntimeError)
    end
end