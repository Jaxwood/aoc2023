require 'test_helper'
require 'day16'

class Day16Test < Minitest::Test
  def test_day16a
    sut = Day16.new
    sut.load('data/day16a.txt')
    assert_equal(46, sut.part1([0, 0], :east))
  end

  def _test_day16_part1
    sut = Day16.new
    sut.load('data/day16.txt')
    assert_equal(7884, sut.part1([0, 0], :east))
  end
end
