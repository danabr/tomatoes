# encoding: utf-8
module Tomatoes
  class Tomato
    attr_reader :task, :start_time, :end_time

    def initialize(task, start_time, end_time)
      @task = task
      @start_time = start_time
      @end_time = end_time
    end

    def time_left_at(time)
      end_time - time
    end
  end

  # Special class that indicate that there is no running tomato
  class NonExistantTomato < Tomato
    def initialize
      time = Time.now
      super("<non existant>", time, time)
    end

    def ==(other)
      other.is_a?(NonExistantTomato)  
    end
  end
end
