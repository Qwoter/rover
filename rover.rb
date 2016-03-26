module RoverStateMachine
  STATES = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  CARDINAL_DIRECTION_TO_STATE = { 'N' => 0, 'E' => 1, 'S' => 2, "W" => 3 }
  STATE_TO_CARDINAL_DIRECTION = CARDINAL_DIRECTION_TO_STATE.invert
  MOVEMENT_STEPS = { 'L' => 3, 'R' => 1 }

  def direction_to_i(direction)
    CARDINAL_DIRECTION_TO_STATE[direction]
  end

  def coordinates_delta(direction)
    STATES[direction]
  end

  def recalculate_direction(direction, command)
    (direction + MOVEMENT_STEPS[command]) % 4
  end

  def direction_to_s(direction)
    STATE_TO_CARDINAL_DIRECTION[@direction]
  end
end

class Plato
  attr_reader :x, :y

  def initialize(coordinates)
    @x, @y = coordinates.split(" ").map(&:to_i)
  end
end

class Rover
  include RoverStateMachine

  def initialize(plato, coordinates)
    @plato = plato
    x, y, direction = coordinates.split(" ")
    @x = x.to_i
    @y = y.to_i
    @direction = direction_to_i(direction)
    @errors = []
  end

  def move(commands)
    commands.split("").each_with_index do |command, index|
      case command
      when 'M'
        do_move
      when 'L', 'R'
        rotate(command)
      else
        raise ArgumentError, "Unknown command \##{index} \'#{command}\'"
      end
    end
  end

  def current_location
    "#{@x} #{@y} #{direction_name}"
  end

  private

  def do_move
    x, y = coordinates_delta(@direction)
    @x += x
    @y += y
    check_out_of_bounds
  end

  def rotate(command)
    @direction = recalculate_direction(@direction, command)
  end

  def direction_name
    direction_to_s(@direction)
  end

  def check_out_of_bounds
    raise RangeError, "Imminent Danger! Rover is out of plato bounds!" if @x > @plato.x or @y > @plato.y
  end
end
