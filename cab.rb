class Cab
  attr_reader :current_floor, :cab_stop_queue, :cab_call_queue #, :floor_requests

  def initialize(opts = {})
    @current_floor = opts[:current_floor] || 1
    @cab_call_queue = opts[:cab_call_queue]
    @cab_stop_queue = []
  end

  def activate!
    return if active?
    @thread = Thread.new do
      loop do
        puts "[cab] hello from cab ##{__id__} on floor #{current_floor}, my stop queue is:\n"
        @cab_stop_queue.each { |call| puts "\t[cab] ##{__id__}: #{call}\n" }
        # puts "[cab] WARNING: cab stop queue contains nil" if @cab_stop_queue.include?(nil)
        call = @cab_call_queue.calls.last
        unless call.nil?
          puts "[cab] attempting to take #{call}\n"
          taken =  @cab_call_queue.take(call)
          @cab_stop_queue << taken unless taken.nil?
        end
        sleep 10
      end
    end
  end

  def deactivate
    @thread && @thread.kill
  end

  def active?
    !!(@thread && @thread.alive?)
  end

  def to_s
    "[cab] id: #{__id__}, current_floor: #{current_floor}"
  end

  # def is_valid_floor_request?(floor_num)
  #   true
  # end

  # def look_for_floor_request
  # end

  # def add_floor_request(floor_num)
  #   if is_valid_floor_request?(floor_num)
  #     @floor_requests.enq floor_num
  #     true
  #   else
  #     false
  #   end
  # end

  # private

  # def start_worker
  #   return if active?
  #   @thread = Thread.new do
  #     while active?
  #       puts "hello from cab ##{number}. request queue is \n"
  #       sleep 12
  #     end
  #   end
  # end

  def drive_up
  end

  def drive_down
  end

  def stop
  end

  def open_doors
    # open
    # pause 10 seconds
  end
end

# cab1 = Cab.new
# cab2 = Cab.new
# cab1.activate
# cab2.activate

# while cab1.active? || cab2.active? do
#   #
# end

# class OperatingPanel
#   attr_reader :num_floors

#   def initialize(num_floors)
#     @num_floors = num_floors
#   end
# end

# class CabShaft
#   attr_reader :cab

#   def initialize(cab = nil)
#     @cab = nil
#   end

#   def add_cab(cab)
#     return false if @cab
#     @cab = cab
#   end

#   def remove_cab
#     @cab = nil
#   end
# end


