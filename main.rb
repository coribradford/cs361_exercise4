# Exercise 5 Part 1 (Exception Handling)

class MentalState
  def auditable?
    # true if the external service is online, otherwise false
  end
  def audit!
    # Could fail if external service is offline
  end
  def do_work
    # Amazing stuff...
  end
end

def audit_sanity(bedtime_mental_state)
  raise ConnectionError if !bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

begin
  new_state = audit_sanity(bedtime_mental_state)
rescue => ConnectionError
  puts "error"
end


# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)

class BedtimeMentalState < MentalState ; end

class MorningMentalState < MentalState ; end

class NullMentalState < MentalState ; end

def audit_sanity(bedtime_mental_state)
  raise ConnectionError if !bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

begin
  new_state = audit_sanity(bedtime_mental_state)
rescue => ConnectionError
  new_state = NullMentalState.new()
end
new_state.do_work

# Exercise 5 Part 3 (Wrapping APIs)

require 'candy_service'

def make_candy_machine()
  machine = CandyMachine.new
end
machine = make_candy_machine()
machine.prepare

if machine.ready?
machine.make!
else
puts "sadness"
end