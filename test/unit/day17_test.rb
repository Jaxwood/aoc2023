require 'test_helper'
require 'day17'

class Day17Test < Minitest::Test
  def test_day17a
    sut = Day17.new
    sut.load('data/day17a.txt')
    assert_equal(102, sut.part1)
  end
end
