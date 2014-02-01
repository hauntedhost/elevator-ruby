# machine_room does the following:
#   creates a call_request_queue
#   creates a call_station for each floor, and pass it the queue. it will sent the queue call_request objects
#   creates cabs
#   ?? create a cab_operation_panel
#   ?? create cab_shafts and pass them cabs
#   ?? create a cab bank and pass it cab_shafts (that may or may not have cabs)

if __FILE__ == $0
  require_relative 'cab'
  require_relative 'call_request'
  require_relative 'call_request_queue'
  require_relative 'call_station'

  Thread.abort_on_exception = true
  q = CallRequestQueue.new

  caller = Thread.new do
    i = 0
    loop do
      request = CallRequest.random
      puts "submitting request: #{request}\n"
      q.add(request)
      sleep 10
    end
  end

  # def fulfill(thread, q)
  #   loop do
  #     request = CallRequest.random
  #     puts "current requests in queue: #{q}\n"
  #     puts "#{thread} trying to fulfill request #{request}\n"
  #     q.take(request)
  #     sleep 3
  #   end
  # end

  threads = (1..3).map do |n|
    Thread.new do
      # fulfill("thread ##{n}", q)
      # sleep 3
      loop do
        request = CallRequest.random
        puts "current requests in queue: #{q}\n"
        puts "thread ##{n} trying to fulfill request #{request}\n"
        q.take(request)
        sleep 3
      end
    end
  end

  threads.each(&:join)
end
