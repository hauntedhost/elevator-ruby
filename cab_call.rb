class CabCall
  attr_accessor :from_floor, :direction, :claimed_by

  def initialize(opts = {})
    @from_floor = opts[:from_floor]
    @direction = opts[:direction]
    @claimed_by = nil
  end

  def claimed?
    !!claimed_by
  end

  def unclaimed?
    !claimed?
  end

  def ==(other)
    self.from_floor == other.from_floor && self.direction == other.direction
  end

  def to_s
    "[call] from_floor: #{from_floor}, direction: #{direction}"
  end

  def self.random
    from_floor = (1..12).to_a.sample
    direction = [:up, :down].sample
    request = new(from_floor: from_floor, direction: direction)
  end
end
