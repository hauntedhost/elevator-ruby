require_relative '../lib/simple_queue'

describe SimpleQueue do
  let(:simple_queue) { SimpleQueue.new }

  describe "#transaction" do
    context "in a multi-threaded environment" do
      before do
        Thread.abort_on_exception = true
      end

      it "accepts a block that yields the queue" do
        simple_queue.transaction { |queue| queue << 12 }
        expect(simple_queue.queue).to include(12)
      end

      it "applies thread safe lock during each transaction" do
        threads = (1..10).map do |n|
          Thread.new do
            loop do
              num = (1..5).to_a.sample
              simple_queue.transaction do |queue|
                queue << num unless queue.include?(num)
              end
            end
          end
        end
        sleep 0.025
        threads.each(&:kill)
        expect(simple_queue.queue).to eq(simple_queue.queue.uniq)
      end
    end
  end

  describe "#count" do
    it "returns number of items in the queue" do
      simple_queue.transaction { |queue| queue << 1 << 2 << 3 }
      expect(simple_queue.count).to eq(3)
    end
  end
end
