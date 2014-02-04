class CabCallUnit
  attr_reader :on_floor, :cab_call_queue

  def initialize(opts = {})
    @on_floor = opts[:on_floor]
    @cab_call_queue = opts[:cab_call_queue]
  end

  def to_s
    ENV['DEBUG'] ? "[unit] on_floor: #{on_floor}" : super
  end
end
