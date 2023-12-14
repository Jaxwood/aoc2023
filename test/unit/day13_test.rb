require 'test_helper'
require 'day13'

class Day13Test < Minitest::Test
  def test_day13a
    sut = Day13.new
    sut.load('data/day13a.txt')
    assert_equal(405, sut.part1)
  end

  def test_day13b
    sut = Day13.new
    sut.load('data/day13a.txt')
    assert_equal(400, sut.part2)
  end

  def test_day13_part1
    sut = Day13.new
    sut.load('data/day13.txt')
    assert_equal(34_993, sut.part1)
  end

  def test_day13_part2
    sut = Day13.new
    sut.load('data/day13.txt')
    assert_equal(29_341, sut.part2)
  end
end
