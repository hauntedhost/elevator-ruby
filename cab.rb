class Cab
  attr_reader :number, :floor, :floor_requests

  @number = 0

  class << self
    attr_accessor :number
  end

  def initialize(request_queue = [])
    self.class.number += 1
    @number = self.class.number
    @request_queue = request_queue
    @floor_requests = Queue.new
  end

  def activate
    return if active?
    @thread = Thread.new do
      loop do
        puts "hello from cab ##{number}! request queue is: #{@request_queue.inspect}\n"
        sleep 12
      end
    end
  end

  def deactivate
    @thread && @thread.kill
  end

  def active?
    !!(@thread && @thread.alive?)
  end

  def is_valid_floor_request?(floor_num)
    true
  end

  def look_for_floor_request
  end

  def add_floor_request(floor_num)
    if is_valid_floor_request?(floor_num)
      @floor_requests.enq floor_num
      true
    else
      false
    end
  end

  private

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

# require 'thread'
# require 'digest/sha1'

# class ConcurrentHash
#   def initialize
#     @reader, @writer = {}, {}
#     @lock = Mutex.new
#   end

#   def [](key)
#     @reader[key]
#   end

#   def []=(key, value)
#     @lock.synchronize {
#       @writer[key] = value
#       @reader, @writer = @writer, @reader
#       @writer[key] = value
#     }
#   end
# end

# class CallRequestQueue
#   attr_reader :requests

#   def initialize
#     @requests = Queue.new
#   end

#   def valid_request?(request)
#     begin
#       # let's be liberal about request implementation
#       [:from_floor, :direction].all? { |k| request.respond_to?(k) || request.has_key?(k) }
#     rescue NoMethodError
#       false
#     end
#   end

#   def in_queue?(request)
#     return unless valid_request?(request)
#     request[:from_floor] + request[:direction]
#     @requests.include?(request)
#   end

#   def add_request(request)
#     @requests.enq request
#   end
# end

# class RequestQueue
#   attr_reader :requests

#   def initialize
#     @requests = []
#     @lock = Mutex.new
#   end

#   def add(obj)
#     @lock.synchronize do
#       if @requests.include?(obj)
#         puts "queue already contains: #{obj.inspect}"
#       else
#         puts "adding: #{obj.inspect}\n"
#         @requests << obj
#       end
#     end
#   end

#   def take(obj)
#     @lock.synchronize do
#       if @requests.include?(obj)
#         puts "removing: #{obj.inspect}"
#         o = @requests.delete(obj)
#         if o.nil?
#           puts "FATAL: #take should never return a nil object"
#           exit!(1)
#         else
#           return o
#         end
#       else
#         puts "queue does not contain: #{obj.inspect}\n"
#         nil
#       end
#     end
#   end
# end

# Thread.abort_on_exception = true
# q = RequestQueue.new

# producer = Thread.new do
#   i = 0
#   loop do
#     widget_num = rand(12)
#     puts "adding widget #{widget_num}\n"
#     q.add(widget_num)
#     sleep 0.25
#   end
# end

# def consume(thread, q)
#   loop do
#     puts "current requests in queue: #{q.requests.inspect}\n"
#     widget_num = rand(12)
#     puts "#{thread} consuming widget #{widget_num}\n"
#     q.take(widget_num)
#     sleep 0.25
#   end
# end

# threads = (1..3).map do |n|
#   Thread.new do
#     consume("thread ##{n}", q)
#     sleep 0.25
#   end
# end

# threads.each(&:join)
