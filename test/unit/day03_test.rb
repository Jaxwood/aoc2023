require "test_helper"
require "day03"

class Day01Test < Minitest::Test
  def test_day03a
    sut = Day03.new
    sut.load("data/day03a.txt")
    assert_equal(4361, sut.part1)
  end

  def test_day03_part1
    sut = Day03.new
    sut.load("data/day03.txt")
    assert_equal(538046, sut.part1)
  end

end

