require_relative '../lib/cab'
require_relative '../lib/cab_call_queue'

describe CabCallQueue do
  before do
    CabCallQueue.any_instance.stub(:puts)
    CabCallQueue.any_instance.stub(:print)
  end

  let(:cab_call_one) { CabCall.new(floor: 3, direction: 'up') }
  let(:cab_call_two) { CabCall.new(floor: 12, direction: 'down') }
  let(:call_queue) { CabCallQueue.new }

  describe "#add" do
    it "adds unique cabs to the queue" do
      call_queue.add(cab_call_one)
      call_queue.add(cab_call_two)
      expect(call_queue.count).to eq(2)
      expect(call_queue.queue).to include(cab_call_one)
      expect(call_queue.queue).to include(cab_call_two)
    end

    it "does not add duplicate cabs to the queue" do
      call_queue.add(cab_call_one)
      call_queue.add(cab_call_one)
      call_queue.add(cab_call_one)
      expect(call_queue.count).to eq(1)
    end

    it "raises argument error if something other than a cab_call is passed" do
      expect{ call_queue.add(1) }.to raise_error(ArgumentError)
    end
  end

  describe "#take" do
    before(:each) do
      call_queue.add(cab_call_one)
      call_queue.add(cab_call_two)
    end

    it "takes a cab_call from the queue" do
      call_queue.take(cab_call_one)
      expect(call_queue.count).to eq(1)
    end

    it "raises argument error if something other than a cab_call is passed" do
      expect{ call_queue.take(1) }.to raise_error(ArgumentError)
    end
  end

  describe "#claim" do
    let(:cab_one) { Cab.new }
    let(:cab_two) { Cab.new }

    before(:each) do
      call_queue.add(cab_call_one)
      call_queue.add(cab_call_two)
    end

    it "claims a cab by setting claimed_by attribute" do
      call_queue.claim(cab_call_one, cab_one)
      expect(cab_call_one.claimed_by).to be(cab_one)
      expect(cab_call_two.claimed_by).not_to be(cab_one)
    end

    it "raises argument error if something other than a cab_call is passed" do
      expect{ call_queue.claim(1, cab_one) }.to raise_error(ArgumentError)
    end

    it "raises argument error if something other than a cab is passed" do
      expect{ call_queue.claim(cab_call_one, 1) }.to raise_error(ArgumentError)
    end
  end

  describe "#where" do
    let(:cab_one) { Cab.new }
    let(:cab_two) { Cab.new }

    before(:each) do
      call_queue.add(cab_call_one)
      call_queue.add(cab_call_two)
    end

    it "finds a match" do
      call_queue.claim(cab_call_one, cab_one)
      cab_calls = call_queue.where(:claimed_by, cab_one)
      expect(cab_calls).to include(cab_call_one)
    end
  end
end
