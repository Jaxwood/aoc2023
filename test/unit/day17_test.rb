require 'test_helper'
require 'day17'

class Day17Test < Minitest::Test
  def test_day17a
    sut = Day17.new
    sut.load('data/day17a.txt')
    assert_equal(102, sut.part1(1, 3))
  end

  def test_day17_part1
    sut = Day17.new
    sut.load('data/day17.txt')
    assert_equal(785, sut.part1(1, 3))
  end
end
