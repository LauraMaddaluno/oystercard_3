require "oystercard.rb"

describe Oystercard do
  it "has initial balnce of zero" do
    expect(subject.balance).to eq(0)
  end
end
