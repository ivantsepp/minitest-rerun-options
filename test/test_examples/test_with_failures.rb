require 'minitest/autorun'

class TestExample < Minitest::Test
  def test_hello_world
    puts "one"
    assert true
  end

  def test_that_will_fail
    assert false
  end

  def test_another_that_will_fail
    assert false
  end

  def test_passing
    puts "two"
    assert true
  end

  def test_another_passing
    puts "three"
    assert true
  end
end
