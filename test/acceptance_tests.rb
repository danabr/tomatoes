# encoding: utf-8
require 'test/unit'

# Accepance tests for the tomato utility
class AcceptanceTests < MiniTest::Unit::TestCase
  TOMATO_FILE = "/tmp/tomatoes.test.csv"

  def test_status_no_tomato_file
    assert_equal "No active tomato\n", tomatoes("status")
  end

  def test_status_empty_tomato_file
    write_tomatoes([])
    assert_equal "No active tomato\n", tomatoes("status")
  end

  def test_status_no_active_tomato
    write_tomatoes([
      ["task1", "2014-02-26 13:40:00", "2014-02-26 14:05:00", "done"]
    ])
    assert_equal "No active tomato\n", tomatoes("status")
  end

  def test_status_active_tomato
    start_time = Time.now
    end_time = start_time + 30*60
    time_format = "%Y-%m-%d %H:%M:%S"
    write_tomatoes([
      ["task1", "2014-02-26 13:40:00", "2014-02-26 14:05:00", "done"],
      ["task2", "2014-02-26 13:40:00", "2014-02-26 14:05:00", "failed"],
      ["task3", start_time.strftime(time_format),
                end_time.strftime(time_format), "new"]
    ])
    assert_match /^Focus on task3! Time left: \d+s/, tomatoes("status")
  end

  def test_help
    expected = ["tomatoes - Manage your time",
                "Usage:",
                "$ tomatoes start  - Start a tomato",
                "$ tomatoes done   - Report tomato finished succesfully",
                "$ tomatoes fail   - Report tomato failed",
                "$ tomatoes status - Get status of current tomato",
                ""].join("\n")

    assert_equal expected, tomatoes("help")
    assert_equal expected, tomatoes("")
    assert_equal expected, tomatoes("makes no sense")
  end

  private

  def tomatoes(command_line)
    `TOMATO_FILE="#{TOMATO_FILE}" ./bin/tomatoes #{command_line}`
  end

  def write_tomatoes(tomatoes)
    header = "task\tstart_time\tend_time\tstate"
    rows = [header] + tomatoes.map {|t| t.join("\t") }
    File.write(TOMATO_FILE, rows.join("\n"))
  end

end
