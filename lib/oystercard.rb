class Oystercard
  MAX_BALANCE = 90
  MINUMUM_FARE = 1

  attr_reader :balance, :entry_station
  
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(value)
    fail "credit cannot be added, card balance exceeds #{MAX_BALANCE}" if value + balance > MAX_BALANCE 
    @balance += value  
  end
  
  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINUMUM_FARE
    @entry_station = station
  end  
  
  def touch_out 
    deduct(MINUMUM_FARE)
    @entry_station = nil
  end
  
  private
  def deduct(value)
    @balance -= value
  end

end
