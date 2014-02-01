class CallStation
  attr_reader :on_floor, :request_queue

  def initialize(on_floor, request_queue)
    @on_floor = on_floor
    @request_queue = request_queue
  end
end
