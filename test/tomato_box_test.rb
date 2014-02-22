# encoding: utf-8
require 'test/unit'
require_relative '../lib/tomatoes'

class TomatoBoxTest < MiniTest::Unit::TestCase
  def test_file_does_not_exist
    box = Tomatoes::TomatoBox.new("does_not_exist.csv")
    assert_equal 0, box.tomatoes.size
    assert_equal Tomatoes::NonExistantTomato.new, box.active_tomato
  end
end
