# encoding: utf-8
require 'test/unit'
require 'time'
require_relative '../lib/tomatoes'

class TomatoBoxTest < MiniTest::Unit::TestCase
  TOMATO_FILE = "/tmp/tomatoes.test.csv"

  def test_file_does_not_exist
    box = Tomatoes::TomatoBox.new("does_not_exist.csv")
    assert_equal 0, box.tomatoes.size
    assert_equal Tomatoes::NonExistantTomato.new, box.active_tomato
  end

  def test_file_is_empty
    File.write(TOMATO_FILE, "")
    box = Tomatoes::TomatoBox.new(TOMATO_FILE)
    assert_equal 0, box.tomatoes.size
    assert_equal Tomatoes::NonExistantTomato.new, box.active_tomato
  end

  def test_file_contains_active_tomato
    box = write_tomatoes([
      ["task1", "2014-02-26 13:40:00", "2014-02-26 14:05:00", "new"]
    ])
    assert_equal 1, box.tomatoes.size
    active = box.active_tomato
    refute_equal Tomatoes::NonExistantTomato.new, active
    assert_equal "task1", active.task
    assert_equal time("2014-02-26 13:40:00"), active.start_time
    assert_equal time("2014-02-26 14:05:00"), active.end_time
    assert active.active?
  end

  def test_file_contains_no_active_tomato
    box = write_tomatoes([
      ["failed", "2014-02-26 13:40:00", "2014-02-26 14:05:00", "failed"],
      ["done", "2014-02-26 13:40:00", "2014-02-26 14:05:00", "done"]
    ])
    assert_equal 2, box.tomatoes.size
    assert_equal Tomatoes::NonExistantTomato.new, box.active_tomato
  end

  def test_file_contains_invalid_tomato
    assert_raises(Tomatoes::InvalidTomato) do
      write_tomatoes([
        ["invalid", "", "", ""],
      ])
    end
  end

  def time(str)
    Time.parse(str)
  end

  def write_tomatoes(tomatoes)
    header = "task\tstart_time\tend_time\tstate"
    rows = [header] + tomatoes.map {|t| t.join("\t") }
    File.write(TOMATO_FILE, rows.join("\n"))
    box = Tomatoes::TomatoBox.new(TOMATO_FILE)
  end
end
