class Cab
  attr_reader :current_floor, :cab_call_queue

  def initialize(opts = {})
    @current_floor = opts[:current_floor] || 1
    @cab_call_queue = opts[:cab_call_queue]
  end

  def activate!
    return if active?
    @thread = Thread.new do
      loop do
        if ENV['DEBUG']
          puts "[cab] hello from cab ##{__id__} on floor #{current_floor}, my stop queue is:\n"
          stop_queue.each { |call| puts "\t[cab] ##{__id__}: #{call}\n" }
        end
        cab_call = cab_call_queue.queue.last
        if cab_call && cab_call.unclaimed?
          puts "[cab] attempting to claim #{cab_call}\n" if ENV['DEBUG']
          claimed = cab_call_queue.claim(cab_call, self)
        end
        sleep 10
      end
    end
  end

  def stop_queue
    cab_call_queue.claimed_by(self)
  end

  def deactivate
    thread && thread.kill
  end

  def active?
    !!(thread && thread.alive?)
  end

  def to_s
    ENV['DEBUG'] ? "[cab] id: #{__id__}, current_floor: #{current_floor}" : super
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

  private

  def thread
    @thread
  end

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


