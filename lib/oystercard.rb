class Oystercard
  MAX_BALANCE = 90
  MINUMUM_FARE = 1

  attr_reader :balance, :journeys
  
  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(value)
    fail "credit cannot be added, card balance exceeds #{MAX_BALANCE}" if value + balance > MAX_BALANCE 

    @balance += value  
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINUMUM_FARE

    @journeys << { entry_station: station }
  end  

  def in_journey?
    @journeys.empty? ? false : !@journeys.last.include?(:exit_station)
  end

  def touch_out(station)
    deduct(MINUMUM_FARE)
    @journeys.last[:exit_station] = station
  end
  
  private

  def deduct(value)
    @balance -= value
  end
end
