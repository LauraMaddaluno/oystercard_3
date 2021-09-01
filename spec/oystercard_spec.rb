require "oystercard.rb"

describe Oystercard do
  it "has initial balnce of zero" do
    expect(subject.balance).to eq(0)
  end
  describe "#top_up" do
    
    it {is_expected.to respond_to(:top_up).with(1).argument}

    it "can top up the balance" do 
      expect{subject.top_up 2}.to change{ subject.balance}.by 2
    end

    
  end
end


# Previous test examples 
# expect(station).to respond_to :dock
# expect(heathrow.planes).to include(boeing_727)
# expect(piggy_bank.coins).to include("50p")
# expect(fizzbuzz(5)).to eq("buzz")
