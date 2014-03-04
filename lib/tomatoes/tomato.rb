# encoding: utf-8
module Tomatoes
  class Tomato
    attr_reader :task, :start_time, :end_time, :state

    def initialize(task, start_time, end_time, state)
      @task = task
      @start_time = start_time
      @end_time = end_time
      @state = state
    end

    def time_left_at(time)
      end_time - time
    end

    def active?
      state == "new"
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
  end
end
