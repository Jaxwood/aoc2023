require 'test_helper'
require 'day24'

class Day24Test < Minitest::Test
  def test_day24a
    sut = Day24.new
    sut.load('data/day24a.txt')
    assert_equal(2, sut.part1)
  end
end
