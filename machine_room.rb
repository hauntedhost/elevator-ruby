require 'debugger'

# machine_room does the following:
# [x] 1. creates a cab_call_queue
# [x] 2. creates one or more cab_call_units for each floor, and passes the queue to each.
# [x]    these will sent the queue cab_call objects
# [x] 3. creates cabs and passes the queue.
# [ ]    cabs will listen to queue and take calls.
# 4. ?? create a cab_operation_panel
# 5. ?? create cab_shafts and pass them cabs
# 6. ?? create a cab bank and pass it cab_shafts (that may or may not have cabs)

if __FILE__ == $0
  require_relative 'cab'
  require_relative 'cab_call'
  require_relative 'cab_call_queue'
  require_relative 'cab_call_unit'

  # create call queue
  puts "[machine room] creating cab call queue"
  cab_call_queue = CabCallQueue.new

  # create cab call units for each floor, pass queue to each
  puts "[machine room] creating call units for each floor"
  FLOORS = 12
  cab_call_units = [].tap do |units|
    1.upto(FLOORS) do |floor_num|
      units << CabCallUnit.new(on_floor: floor_num, cab_call_queue: cab_call_queue)
    end
  end
  puts "[machine room] cab call units created:"
  cab_call_units.each { |unit| puts "\t#{unit}" }

  # create a few cabs and pass the queue to each
  TOTAL_CABS = 3
  puts "[machine room] creating #{TOTAL_CABS} cabs"
  cabs = TOTAL_CABS.times.inject([]) do |cabs, num|
    cab = Cab.new(cab_call_queue: cab_call_queue)
    cabs << cab
  end
  puts "[machine room] cabs created:"
  cabs.each { |cab| puts "\t#{cab}" }

  # activate all cabs
  puts "[machine room] activating all cabs"
  cabs.each { |cab| cab.activate! }

  Thread.abort_on_exception = true
  caller = Thread.new do
    i = 0
    loop do
      unit = cab_call_units.sample
      call = CabCall.new(from_floor: unit.on_floor, direction: %w[up down].sample)
      puts "[machine room] artificially triggering unit #{unit} to make call #{call}\n"
      cab_call_queue.add(call)
      sleep 12
    end
  end

  # threads = (1..3).map do |n|
  #   Thread.new do
  #     # fulfill("thread ##{n}", q)
  #     # sleep 3
  #     loop do
  #       puts "[machine room] current calls in queue: #{cab_call_queue}\n"
  #       # unit = cab_call_units.sample
  #       # call = CabCall.new(from_floor: unit.on_floor, direction: %[up down].sample)
  #       # puts "unit #{unit} in thread #{n} making call #{call}\n"
  #       # cab_call_queue.take(call)
  #       sleep 3
  #     end
  #   end
  # end

  # threads.each(&:join)

  caller.join
end
