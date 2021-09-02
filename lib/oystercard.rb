class Oystercard
  MAX_BALANCE = 90
  MINUMUM_FARE = 1

  attr_reader :balance 
  
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(value)
    fail "credit cannot be added, card balance exceeds #{MAX_BALANCE}" if value + balance > MAX_BALANCE 
    @balance += value  
  end

  
  
  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Insufficient funds" if @balance < MINUMUM_FARE
    @in_journey = true
  end  
  
  def touch_out 
    deduct(MINUMUM_FARE)
    @in_journey = false
  end
  
  private
  def deduct(value)
    @balance -= value
  end

end
