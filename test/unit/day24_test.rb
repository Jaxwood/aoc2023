require 'test_helper'
require 'day24'

class Day24Test < Minitest::Test
  def test_day24a
    sut = Day24.new
    sut.load('data/day24a.txt', 7, 27)
    assert_equal(2, sut.part1)
  end

  def test_day24b
    sut = Day24.new
    sut.parse('data/day24a.txt')
    assert_equal(47, sut.part2)
  end

  def test_day24_part1
    sut = Day24.new
    sut.load('data/day24.txt', 200_000_000_000_000, 400_000_000_000_000)
    assert_equal(18_651, sut.part1)
  end

  def test_day24_part2
    sut = Day24.new
    sut.parse('data/day24.txt')
    assert_equal(546_494_494_317_645, sut.part2)
  end
end
