require 'test_helper'
require 'day12'

class Day12Test < Minitest::Test
  def test_day12a
    sut = Day12.new
    sut.load('data/day12a.txt')
    assert_equal(21, sut.part1)
  end

  def test_day12_part1
    sut = Day12.new
    sut.load('data/day12.txt')
    assert_equal(7047, sut.part1)
  end
end
