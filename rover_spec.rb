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

  context 'moving on plato with correct commands' do
    it 'can move and rotate in one direction' do
      rover1.move("LMLMLMLMM")
      rover2.move("MMRMMRMRRM")
      expect(rover1.current_location).to eq("1 3 N")
      expect(rover2.current_location).to eq("5 1 E")
    end

    it 'can move and rotate in both directions' do
      rover1.move("LMRRMM")
      expect(rover1.current_location).to eq("2 2 E")
    end
  end

  context 'moving with wrong commands' do
    it 'raises Argument Error' do
      expect { rover1.move("LMLMYMLMM") }.to raise_error(ArgumentError, "Unknown command #4 'Y'")
    end
  end

  context 'moving out of plato' do
    it 'raises Range Error on positive bounds' do
      expect { rover1.move("MMMMMMMMMMM") }.to raise_error(RangeError, "Imminent Danger! Rover is out of plato bounds!")
    end
    it 'raises Range Error on negative bounds' do
      expect { rover1.move("LMMMMMMMMMMM") }.to raise_error(RangeError, "Imminent Danger! Rover is out of plato bounds!")
    end
  end
end
