require 'rspec/autorun'
require_relative 'rover'

RSpec.describe Rover do
  subject(:plato) do
    Plato.new("5 5")
  end

  subject(:rover1) do
    Rover.new(plato, "1 2 N")
  end

  subject(:rover2) do
    Rover.new(plato, "3 3 E")
  end

  context 'moving on plato' do
    it 'can correctly move' do
      rover1.move("LMLMLMLMM")
      rover2.move("MMRMMRMRRM")
      expect(rover1.current_location).to eq("1 3 N")
      expect(rover2.current_location).to eq("5 1 E")
    end
  end
end
