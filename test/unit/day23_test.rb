require 'test_helper'
require 'day23'

class Day23Test < Minitest::Test
  def test_day23a
    sut = Day23.new
    sut.load('data/day23a.txt')
    assert_equal(94, sut.part1)
  end

  def test_day23b
    sut = Day23.new
    sut.load('data/day23a.txt')
    assert_equal(154, sut.part2)
  end

  def test_day23a_part1
    sut = Day23.new
    sut.load('data/day23.txt')
    assert_equal(2430, sut.part1)
  end

  def test_day23a_part2
    sut = Day23.new
    sut.load('data/day23.txt')
    assert_equal(0, sut.part2)
  end
end
