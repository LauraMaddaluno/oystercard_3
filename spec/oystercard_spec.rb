require "oystercard.rb"

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

  it "has initial balance of zero" do
    expect(subject.balance).to eq(0)
  end

  it "has an inital not in journey status" do
    expect(subject).not_to be_in_journey
  end

  it "can change the status to true when touched in" do
    subject.top_up(1)
    subject.touch_in(entry_station)
    expect(subject).to be_in_journey
  end
  
  it " change the status to not in journey when touched out" do 
    subject.top_up(1)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject).not_to be_in_journey
  end
  
  describe "#top_up" do
    it "can top up the balance" do 
      expect { subject.top_up(2) }.to change { subject.balance }.by(2)
    end

    it "prevents a balance of over £90" do
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(15) }.to raise_error("credit cannot be added, card balance exceeds #{maximum_balance}")
    end
  end

  it "should return an error if insufficient funds" do
    expect { subject.touch_in(entry_station) }.to raise_error("Insufficient funds")
  end

  it "it when touch out it should charge for the travel" do
    subject.top_up(5)
    subject.touch_in(entry_station)
    expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(- Oystercard::MINUMUM_FARE)
  end

  it "should return the entry station" do
    subject.top_up(1)
    subject.touch_in(entry_station)
    expect(subject.journeys.last).to eq(entry_station: entry_station)
  end

  it "should change entry_station to nil after touch_out" do
    subject.top_up(1)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys.last).to include(exit_station: exit_station)
  end

  describe '#journeys' do
    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end

    it 'stores journeys' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include(journey)
    end
  end
end