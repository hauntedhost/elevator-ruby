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

  def take(call)
    @lock.synchronize do
      if @calls.include?(call)
        puts "[queue] removing: #{call}"
        @calls.delete(call) # returns deleted call
      else
        puts "[queue] does not contain: #{call}\n"
        nil
      end
    end
  end

  def to_s
    @calls.map { |call| "[call] from_floor: #{call.from_floor}, direction: #{call.direction}" }.join(', ')
                                                                                              .insert(0, '[')
                                                                                              .insert(-1, ']')
  end
end
