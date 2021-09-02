require "oystercard.rb"

describe Oystercard do

  let(:station) { double :station }

  it "has initial balance of zero" do
    expect(subject.balance).to eq(0)
  end

  it "has an inital not in journey status" do
    expect(subject.in_journey?).to be false
  end

  it {is_expected.to respond_to(:touch_in)}

  it "can change the status to true when touched in" do
    subject.top_up(1)
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end 

  it {is_expected.to respond_to(:touch_out)} 
  
  it " change the status to not in journey when touched out" do 
    subject.top_up(1)
    subject.touch_in(station)
    subject.touch_out
    expect(subject).not_to be_in_journey
  end
  
  describe "#top_up" do
    
    it {is_expected.to respond_to(:top_up).with(1).argument}

    it "can top up the balance" do 
      expect{subject.top_up 2}.to change{ subject.balance}.by 2
    end

    it "prevents a balance of over £90" do
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up(maximum_balance)
      expect{subject.top_up 15}.to raise_error "credit cannot be added, card balance exceeds #{maximum_balance}"
    end
  end

  it "should return an error if insufficient funds" do
    expect { subject.touch_in(station) }.to raise_error "Insufficient funds"
  end

  it "it when touch out it should charge for the travel" do
    subject.top_up(5)
    subject.touch_in(station)
    expect{subject.touch_out}.to change{subject.balance }.by (- Oystercard::MINUMUM_FARE)
  end

  
  it "should return the entry station" do
    subject.top_up(1)
    subject.touch_in(station)
    expect(subject.entry_station).to eq(station)
  end

  it "should change entry_station to nil after touch_out" do
    subject.top_up(1)
    subject.touch_in(station)
    subject.touch_out
    expect(subject.entry_station).to eq nil
  end
end