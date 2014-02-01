class CallRequest
  attr_accessor :from_floor, :direction

  def initialize(opts = {})
    @from_floor = opts[:from_floor]
    @direction = opts[:direction]
  end

  def ==(other)
    from_floor == other.from_floor && direction == other.direction
  end

  def to_s
    "from_floor: #{from_floor}, direction: #{direction}"
  end

  def self.random
    from_floor = rand(12)
    direction = %w[up down].sample
    request = new(from_floor: from_floor, direction: direction)
  end
end
