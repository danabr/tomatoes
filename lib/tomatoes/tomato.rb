# encoding: utf-8
module Tomatoes
  class Tomato
    attr_accessor :task, :start_time, :end_time, :state

    def initialize(task, start_time, end_time, state)
      @task = task
      @start_time = start_time
      @end_time = end_time
      @state = state
    end

    def time_left_at(time)
      end_time - time
    end

    def overdue_at?(time)
      time_left_at(time) < 0      
    end

    def active?
      state == "new"
    end

    def ==(other)
      other.task == self.task &&
      other.start_time.to_i == self.start_time.to_i &&
      other.end_time.to_i == self.end_time.to_i &&
      other.state == self.state
    end
  end

  # Special class that indicate that there is no running tomato
  class NonExistantTomato < Tomato
    def initialize
      time = Time.now
      super("<non existant>", time, time, "nonexistant")
    end

    def ==(other)
      other.is_a?(NonExistantTomato)
    end

    def active?
      false
    end

    def overdue_at?(time)
      false
    end
  end
end
