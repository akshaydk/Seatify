require 'rspec/autorun'
require_relative './../Allocator.rb'

describe 'Allocator,' do
    it 'will generate the aisle and window counts when given a labeled array' do
        allocator = Allocator.new( [['W', 'A'], ['A','W']], 2)
        expect(allocator.allocate).to eq([["W", "A1"], ["A2", "W"]])

        allocator = Allocator.new( [["W", "A", "A", "W"], [0, 0, "A", "W"]], 4)
        expect(allocator.allocate).to eq([["W4", "A1", "A2", "W"], [0, 0, "A3", "W"]])
    end

    it 'will raise an exception when passengers are more than seats' do
        allocator = Allocator.new( [['W', 'A'], ['A','W']], 10)
        expect{allocator.allocate}.to raise_error(RuntimeError)
    end
end