require 'test_helper'
require 'day01'

class Day01Test < Minitest::Test
  def test_day01a
    sut = Day01.new
    sut.load('data/day01a.txt')
    assert_equal(142, sut.part1)
  end

  def test_day01b
    sut = Day01.new
    sut.load('data/day01b.txt')
    assert_equal(281, sut.part2)
  end

  def test_day01_part01
    sut = Day01.new
    sut.load('data/day01.txt')
    assert_equal(52_974, sut.part1)
  end

  def test_day01_part02
    sut = Day01.new
    sut.load('data/day01.txt')
    assert_equal(53_340, sut.part2)
  end
end
