# encoding: utf-8
require 'test/unit'
require_relative '../lib/tomatoes'

class TomatoTest < MiniTest::Unit::TestCase
  def test_initialize
    start_time = Time.now
    end_time = Time.now+1
    task = "The task"
    tomato = Tomatoes::Tomato.new(task, start_time, end_time, "new")
    assert_equal task, tomato.task
    assert_equal start_time, tomato.start_time
    assert_equal end_time, tomato.end_time
  end

  def test_time_left_at
    start_time = Time.now
    end_time = start_time + 10
    tomato = Tomatoes::Tomato.new("time test", start_time, end_time, "new")
    assert_equal 10, tomato.time_left_at(start_time)
    assert_equal 5, tomato.time_left_at(start_time + 5)
    assert_equal 0, tomato.time_left_at(end_time)
  end

  def test_active
    refute Tomatoes::NonExistantTomato.new.active?

    active = Tomatoes::Tomato.new("active", Time.now, Time.now, "new")
    assert active.active?

    failed = Tomatoes::Tomato.new("failed", Time.now, Time.now, "failed")
    refute failed.active?

    done = Tomatoes::Tomato.new("done", Time.now, Time.now, "done")
    refute failed.active?
  end
end

