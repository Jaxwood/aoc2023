require 'test_helper'
require 'day23'

class Day23Test < Minitest::Test
  def test_day23a
    sut = Day23.new
    sut.load('data/day23a.txt')
    assert_equal(94, sut.part1)
  end

  def test_day23a_part1
    sut = Day23.new
    sut.load('data/day23.txt')
    assert_equal(2432, sut.part1) # too high
  end
end
