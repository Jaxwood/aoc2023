require "test_helper"
require "day02"

class Day01Test < Minitest::Test
  def test_day02a
    sut = Day02.new
    sut.load("data/day02a.txt")
    assert_equal(8, sut.part1)
  end

  def test_day02
    sut = Day02.new
    sut.load("data/day02.txt")
    assert_equal(2617, sut.part1)
  end
end

