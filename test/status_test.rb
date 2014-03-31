# encoding: utf-8
require 'test/unit'
require 'stringio'
require_relative '../lib/tomatoes'
require_relative 'lib/fake_tomato_box'

class StatusTest < MiniTest::Unit::TestCase

  def test_no_active_tomato
    output = run_command(Tomatoes::NonExistantTomato.new)
    assert_equal "No active tomato", output[0]
    assert_equal 1, output.length
  end

  def test_active_tomato_without_name
    start_time = Time.now
    output = run_command(Tomatoes::Tomato.new("", start_time, start_time+10, "new"))
    assert_match /^Focus! Time left: \d+s$/, output[0]
    assert_equal 1, output.length
  end

  def test_active_tomato_with_name
    start_time = Time.now
    tomato = Tomatoes::Tomato.new("The task", start_time, start_time+10, "new")
    output = run_command(tomato)
    assert_match /^Focus on The task! Time left: \d+s$/, output[0]
    assert_equal 1, output.length
  end

  def test_overdue_tomato
    start_time = Time.now-10
    tomato = Tomatoes::Tomato.new("The task", start_time, start_time+1, "new")
    output = run_command(tomato)
    assert_match "The task has finished.", output[0]
    assert_match "Report success or failure with tomatoes done or tomatoes fail.", output[1]
    assert_equal 2, output.length
  end

  def test_overdue_tomato_without_name
    start_time = Time.now-10
    tomato = Tomatoes::Tomato.new("", start_time, start_time+1, "new")
    output = run_command(tomato)
    assert_match "The tomato has finished.", output[0]
    assert_match "Report success or failure with tomatoes done or tomatoes fail.", output[1]
    assert_equal 2, output.length
  end

  private

  def run_command(tomato)
    out = StringIO.new
    box = FakeTomatoBox.new(tomato)
    command = Tomatoes::Commands::Status.new(box, [], out)
    command.run
    out.string.split("\n")
  end
end
