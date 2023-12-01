require "test_helper"
require "day01"

class Day01Test < Minitest::Test
  def test_day01
    sut = Day01.new
    sut.load("data/day01.txt")
    assert_equal(142, sut.part1)
  end

  def test_day01_part01
    sut = Day01.new
    sut.load("data/day01_part1.txt")
    assert_equal(52974, sut.part1)
  end
end

