class CallRequestQueue
  attr_reader :requests

  def initialize
    @requests = []
    @lock = Mutex.new
  end

  def add(request)
    @lock.synchronize do
      if @requests.include?(request)
        puts "queue already contains: #{request}"
      else
        puts "adding: #{request}\n"
        @requests << request
      end
    end
  end

  def take(request)
    @lock.synchronize do
      if @requests.include?(request)
        puts "removing: #{request}"
        @requests.delete(request) # returns deleted request
        # if taken.nil?
        #   puts "FATAL: #take should never return a nil object"
        #   exit!(1)
        # else
        #   return taken
        # end
      else
        puts "queue does not contain: #{request}\n"
        nil
      end
    end
  end

  def to_s
    @requests.map { |r| "from_floor: #{r.from_floor}, direction: #{r.direction}" }.join(', ')
                                                                                  .insert(0, '[')
                                                                                  .insert(-1, ']')
  end
end
