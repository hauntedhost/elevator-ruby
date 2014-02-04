class CabCall
  include Comparable
  attr_accessor :floor, :direction, :claimed_by

  def initialize(opts = {})
    @floor = opts[:floor]
    @direction = opts[:direction]
    @claimed_by = nil
  end

  def claimed?
    !!claimed_by
  end

  def unclaimed?
    !claimed?
  end

  def <=> other
    self.floor <=> other.floor
  end

  def ==(other)
    begin
      self.floor == other.floor && self.direction == other.direction
    rescue NoMethodError
      false
    end
  end

  def self.random
    floor = (1..12).to_a.sample
    direction = [:up, :down].sample
    new(floor: floor, direction: direction)
  end

  def to_s
    ENV['DEBUG'] ? "[call] floor: #{floor}, direction: #{direction}" : super
  end
end
