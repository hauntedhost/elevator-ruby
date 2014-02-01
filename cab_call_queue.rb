class CabCallQueue
  attr_reader :calls

  def initialize
    @calls = []
    @lock = Mutex.new
  end

  def add(call)
    @lock.synchronize do
      if @calls.include?(call)
        puts "[queue] already contains: #{call}"
      else
        puts "[queue] adding: #{call}\n"
        @calls << call
      end
    end
  end

  def claim(call, cab)
    @lock.synchronize do
      if @calls.include?(call) && call.unclaimed?
        puts "[queue] claiming: #{call}"
        call.claimed_by = cab
      else
        puts "[queue] does not contain: #{call}\n"
        nil
      end
    end
  end

  def calls_for(cab)
    calls.select { |call| call.claimed_by == cab }
  end

  def to_s
    message = @calls.map do |call|
      "\n\t[call] from_floor: #{call.from_floor}, direction: #{call.direction}, claimed_by: #{call.claimed_by}"
    end
    message.join
  end
end
