require_relative 'rover'

plato_args = gets.strip
number_of_rovers = gets.strip.to_i
result = []

plato = Plato.new(plato_args)

number_of_rovers.times do
  rover_start_pos = gets.strip
  rover_commands = gets.strip

  rover = Rover.new(plato, rover_start_pos)
  rover.move(rover_commands)
  result << rover.current_location
end

puts result
