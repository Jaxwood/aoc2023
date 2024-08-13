require 'test_helper'
require 'day24'

class Day24Test < Minitest::Test
  def test_day24a
    sut = Day24.new
    sut.load('data/day24a.txt', 7, 27)
    assert_equal(2, sut.part1)
  end

  def test_day24
    sut = Day24.new
    sut.load('data/day24.txt', 200000000000000, 400000000000000)
    assert_equal(18651, sut.part1)
  end
end
