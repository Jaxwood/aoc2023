require "test_helper"
require "day04"

class Day01Test < Minitest::Test
  def test_day04a
    sut = Day04.new
    sut.load("data/day04a.txt")
    assert_equal(13, sut.part1)
  end

  def test_day04
    sut = Day04.new
    sut.load("data/day04.txt")
    assert_equal(20107, sut.part1)
  end
end
