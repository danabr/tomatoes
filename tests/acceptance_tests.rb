# encoding: utf-8
require 'test/unit'

# Accepance tests for the tomato utility
class AcceptanceTests < MiniTest::Unit::TestCase

  def test_status_no_tomato_file
    assert_equal "No active tomato\n", tomatoes("status")
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
    `./bin/tomatoes #{command_line}`
  end

end
