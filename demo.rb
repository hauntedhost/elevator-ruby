require 'debugger'
require_relative 'lib/machine_room'

if __FILE__ == $0
  ENV['DEBUG'] = 'true'
  machine_room = MachineRoom.new
  machine_room.power_on
  machine_room.play_simulation
end
