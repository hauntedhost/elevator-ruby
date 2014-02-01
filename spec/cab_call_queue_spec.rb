require 'spec_helper'

describe CabCallQueue do
  before do
    CabCallQueue.any_instance.stub(:puts)
    CabCallQueue.any_instance.stub(:print)
  end

  context "in a threaded environment" do
    let(:queue) { CabCallQueue.new }

    before do
      Thread.abort_on_exception = true
    end

    it "only adds unique items" do
      threads = (1..20).map do |n|
        Thread.new do
          loop do
            number = (1..10).to_a.sample
            queue.add(number)
          end
        end
      end
      sleep 0.15
      threads.each(&:kill)
      expect(queue.calls).to eq(queue.calls.uniq)
    end

    it "allows unique items to be taken" do
      1.upto(100) { |num| queue.add(num) }
      items = []
      threads = (0..5).map do |t|
        items[t] = []
        Thread.new do
          loop do
            number = (1..100).to_a.sample
            item = queue.take(number)
            items[t] << item unless item.nil?
            sleep 0.001
          end
        end
      end
      sleep 0.15
      threads.each(&:kill)
      expect(items.flatten).to eq(items.flatten.uniq)
      expect(queue.calls & items.flatten).to be_empty
    end
  end
end
