require 'test/unit'

# Accepance tests for the tomato utility
class AcceptanceTests < MiniTest::Unit::TestCase

  def test_status_no_tomato_file
    expected = "No active tomato\n"
    output = `./bin/tomatoes status`
    assert_equal expected, output
  end

end
