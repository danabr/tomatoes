# encoding: utf-8
require 'test/unit'
require 'stringio'
require_relative '../lib/tomatoes'

class StatusTest < MiniTest::Unit::TestCase
  FakeTomatoBox = Struct.new(:active_tomato)

  def test_no_active_tomato
    output = run_command(Tomatoes::NonExistantTomato.new)
    assert_equal "No active tomato\n", output
  end

  def test_active_tomato_without_name
    start_time = Time.now
    output = run_command(Tomatoes::Tomato.new("", start_time, start_time+10))
    assert_match /Focus! Time left: \d+s/, output
  end

  def test_active_tomato_with_name
    start_time = Time.now
    tomato = Tomatoes::Tomato.new("The task", start_time, start_time+10)
    output = run_command(tomato)
    assert_match /Focus on The task! Time left: \d+s/, output
  end

  private

  def run_command(tomato)
    out = StringIO.new
    box = FakeTomatoBox.new(tomato)
    command = Tomatoes::Commands::Status.new(box, [], out)
    command.run
    out.string
  end
end
