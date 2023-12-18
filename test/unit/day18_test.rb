require 'test_helper'
require 'day18'

class Day18Test < Minitest::Test
  def test_day18a
    sut = Day18.new
    sut.load('data/day18a.txt')
    assert_equal(62, sut.part1)
  end

  def test_day18b
    sut = Day18.new
    sut.load('data/day18a.txt')
    assert_equal(952_408_144_115, sut.part2)
  end

  def test_day18_part1
    sut = Day18.new
    sut.load('data/day18.txt')
    assert_equal(40_745, sut.part1)
  end

  def test_day18_part2
    sut = Day18.new
    sut.load('data/day18.txt')
    assert_equal(90_111_113_594_927, sut.part2)
  end
end
