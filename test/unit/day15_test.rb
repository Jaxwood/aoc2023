require 'test_helper'
require 'day15'

class Day15Test < Minitest::Test
  def test_day15a
    sut = Day15.new
    sut.load('data/day15a.txt')
    assert_equal(1320, sut.part1)
  end

  def test_day15b
    sut = Day15.new
    sut.load('data/day15a.txt')
    assert_equal(145, sut.part2)
  end

  def test_day15_part1
    sut = Day15.new
    sut.load('data/day15.txt')
    assert_equal(505_379, sut.part1)
  end

  def test_day15_part2
    sut = Day15.new
    sut.load('data/day15.txt')
    assert_equal(263_211, sut.part2)
  end
end
