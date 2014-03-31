# encoding: utf-8
require 'test/unit'
require 'stringio'
require_relative '../lib/tomatoes'
require_relative 'lib/fake_tomato_box'

class StartTest < MiniTest::Unit::TestCase

  def test_no_active_tomato
    box, output = run_command(Tomatoes::NonExistantTomato.new, [])
    assert_equal "Tomato started.", output[0]
    assert_equal 1, output.length
    assert_equal [[:add, [""]]], box.calls
  end

  private

  def run_command(tomato, args)
    out = StringIO.new
    box = FakeTomatoBox.new(tomato)
    command = Tomatoes::Commands::Start.new(box, [], out)
    command.run
    return box, out.string.split("\n")
  end
end
