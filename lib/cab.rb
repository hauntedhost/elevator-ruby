require 'debugger'

class Cab
  attr_reader :current_floor, :cab_call_queue, :my_queue

  def initialize(opts = {})
    Thread.abort_on_exception = true
    @current_floor = opts[:current_floor] || 1.0
    @cab_call_queue = opts[:cab_call_queue]
    @my_queue = []
  end

  def activate!
    return if active?
    @thread = Thread.new do
      loop do
        # if ENV['DEBUG']
        #   puts "[cab] hello from cab ##{__id__} on floor #{current_floor}, my stop queue is:\n"
        #   my_queue.each { |call| puts "\t[cab] ##{__id__}: #{call}\n" }
        # end

        # drive_up!
        puts "[cab] current_floor = #{current_floor}"

        if my_queue.empty? && cab_call_queue.any?
          claimed_call = cab_call_queue.claim(cab_call_queue.next, self)

          if claimed_call
            puts "[cab] claimed #{claimed_call}"
            @my_queue << claimed_call
            drive_to_floor(claimed_call.floor)
          end
        end

        # if my_queue.any?
        #   # if moving?
        #     # see if there is a call between current_floor + 1 and next stop
        #   # else
        #     # get us moving
        #   # end
        # else
        #   # try to claim a call
        # end

        # cab_call = cab_call_queue.queue.last
        # if cab_call && cab_call.unclaimed?
        #   puts "[cab] attempting to claim #{cab_call}\n" if ENV['DEBUG']
        #   claimed = cab_call_queue.claim(cab_call, self)
        # end
        sleep 1
      end
    end
  end

  # def my_queue
  #   cab_call_queue.claimed_by(self)
  # end

  def deactivate
    thread && thread.kill
  end

  def active?
    !!(thread && thread.alive?)
  end

  def driving?
    !!(drive_thread && drive_thread.alive?)
  end

  def to_s
    ENV['DEBUG'] ? "[cab] id: #{__id__}, current_floor: #{current_floor}" : super
  end

  private

  def thread
    @thread
  end

  def drive_thread
    @drive_thread
  end

  def drive_to_floor(floor)
    return if driving? || floor == current_floor
    if current_floor > floor
      drive_down_to(floor)
    else
      drive_up_to(floor)
    end
  end

  def drive_down_to(floor)
    return if driving? || floor == current_floor
    @drive_thread = Thread.new do
      while current_floor > floor
        @current_floor = (@current_floor - 0.10).round(2)
        @current_floor = floor if @current_floor < floor
        sleep 0.5
      end
    end
  end

  def drive_up_to(floor)
    return if driving? || floor == current_floor
    @drive_thread = Thread.new do
      while current_floor < floor
        @current_floor = (@current_floor + 0.10).round(2)
        @current_floor = floor if @current_floor > floor
        sleep 0.5
      end
    end
  end

  def stop
  end

  def open_doors
    # open then wait 10 seconds
  end
end
