class Plato
  attr_reader :x, :y

  def initialize(coordinates)
    @x, @y = coordinates.split(" ").map(&:to_i)
  end
end

class Rover
  def initialize(plato, coordinates)
  end

  def plato
  end

  def move(commands)
  end

  def current_location
  end

  private
  def rotate
  end

end
