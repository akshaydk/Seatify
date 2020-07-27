require 'rspec/autorun'
require_relative './../Labels.rb'

describe 'Labels' do
    it 'will generate labels for given seating arrangement' do
        labels = Labels.new([[0,0,0,0],[0,0,0,0]], [[1,2],[2,2]])
        expect(labels.add).to eq([["W", "A", "A", "W"], [0, 0, "A", "W"]])
    end
end