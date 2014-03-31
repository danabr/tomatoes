class FakeTomatoBox 
  attr_accessor :active_tomato
  attr_reader :calls

  def initialize(active_tomato)
    self.active_tomato = active_tomato
    @calls = []
  end

  def method_missing(method, *args)
    @calls << [method, args]
  end
end
