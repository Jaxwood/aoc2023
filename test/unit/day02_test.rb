require 'test_helper'
require 'day02'

class Day01Test < Minitest::Test
  def test_day02a
    sut = Day02.new
    sut.load('data/day02a.txt')
    assert_equal(8, sut.part1)
  end

  def test_day02b
    sut = Day02.new
    sut.load('data/day02a.txt')
    assert_equal(2286, sut.part2)
  end

  def test_day02_part1
    sut = Day02.new
    sut.load('data/day02.txt')
    assert_equal(2617, sut.part1)
  end

  def test_day02_part2
    sut = Day02.new
    sut.load('data/day02.txt')
    assert_equal(59_795, sut.part2)
  end
end
