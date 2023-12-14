require 'test_helper'
require 'day14'

class Day14Test < Minitest::Test
  def test_day14a
    sut = Day14.new
    sut.load('data/day14a.txt')
    assert_equal(136, sut.part1)
  end

  def test_day14b
    sut = Day14.new
    sut.load('data/day14a.txt')
    assert_equal(64, sut.part2)
  end

  def test_day14_part1
    sut = Day14.new
    sut.load('data/day14.txt')
    assert_equal(108_792, sut.part1)
  end

  def test_day14_part2
    sut = Day14.new
    sut.load('data/day14.txt')
    assert_equal(99_118, sut.part2)
  end
end
