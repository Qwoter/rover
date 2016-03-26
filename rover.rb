class Plato
  attr_reader :x, :y

  def initialize(coordinates)
    @x, @y = coordinates.split(" ").map(&:to_i)
  end
end

class Rover
  STATES = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  CARDINAL_DIRECTION_TO_STATE = { 'N' => 0, 'E' => 1, 'S' => 2, "W" => 3 }
  STATE_TO_CARDINAL_DIRECTION = CARDINAL_DIRECTION_TO_STATE.invert
  MOVEMENT_STEPS = { 'L' => 3, 'R' => 1 }

  def initialize(plato, coordinates)
    @plato = plato
    @x, @y, @direction = coordinates.split(" ")
    @x = @x.to_i
    @y = @y.to_i
    @direction_number = CARDINAL_DIRECTION_TO_STATE[@direction]
  end

  def move(commands)
    commands.split("").each do |command|
      if command == "M"
        do_move
      else
        rotate(command)
      end
    end
  end

  def current_location
    "#{@x} #{@y} #{@direction}"
  end

  private

  def do_move
    x, y = STATES[@direction_number]
    @x += x
    @y += y
  end

  def rotate(command)
    @direction_number = (@direction_number + MOVEMENT_STEPS[command]) % 4
    @direction = STATE_TO_CARDINAL_DIRECTION[@direction_number]
  end
end
