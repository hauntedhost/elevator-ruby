class SimpleQueue
  attr_reader :queue

  def initialize(queue = [])
    @queue = queue
    @lock = Mutex.new
  end

  def transaction(&blk)
    @lock.synchronize do
      blk.call(queue)
    end
  end

  def count
    queue.count
  end

  def any?
    queue.any?
  end

  def empty?
    queue.empty?
  end
end
