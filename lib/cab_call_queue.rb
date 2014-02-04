require 'debugger'
require_relative 'cab'
require_relative 'cab_call'
require_relative 'simple_queue'

class CabCallQueue < SimpleQueue
  def initialize(queue = [])
    super([])
  end

  def add(cab_call)
    validates_cab_call!(cab_call)

    transaction do |queue|
      if queue.include?(cab_call)
        puts "[queue] already contains: #{cab_call}" if ENV['DEBUG']
        nil
      else
        puts "[queue] adding: #{cab_call}\n" if ENV['DEBUG']
        queue << cab_call
      end
    end
  end

  def take(cab_call)
    validates_cab_call!(cab_call)

    transaction do |queue|
      if queue.include?(cab_call)
        puts "[queue] removing: #{cab_call}" if ENV['DEBUG']
        queue.delete(cab_call) # returns deleted cab_call
      else
        puts "[queue] does not contain: #{cab_call}\n" if ENV['DEBUG']
        nil
      end
    end
  end

  def claim(cab_call, cab)
    validates_cab_call!(cab_call)
    validates_cab!(cab)

    transaction do |queue|
      if queue.include?(cab_call) && cab_call.unclaimed?
        puts "[queue] claiming: #{cab_call}" if ENV['DEBUG']
        cab_call.claimed_by = cab
        cab_call
      else
        puts "[queue] does not contain: #{cab_call}\n" if ENV['DEBUG']
        nil
      end
    end
  end

  def claimed_by(cab)
    where(:claimed_by, cab)
  end

  def where(key, val)
    queue.select { |cab_call| cab_call.send(key) == val }
  end

  def to_s
    if ENV['DEBUG']
      message = queue.map do |cab_call|
        "\n\t[cab_call] from_floor: #{cab_call.from_floor}, direction: #{cab_call.direction}, claimed_by: #{cab_call.claimed_by}"
      end
      message.join
    else
      super
    end
  end

  private

  def validates_cab!(cab)
    raise ArgumentError, "#claim needs a cab" unless cab.is_a?(Cab)
  end

  def validates_cab_call!(cab_call)
    raise ArgumentError, "#claim needs a cab_call" unless cab_call.is_a?(CabCall)
  end
end
