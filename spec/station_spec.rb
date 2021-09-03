require 'station'

describe Station do
  subject { Station.new("Euston", 1) }

  it "exposes a name" do 
    expect(subject.name).to eq('Euston')
  end

  it "exposes a zone" do 
    expect(subject.zone).to eq(1)
  end
end 