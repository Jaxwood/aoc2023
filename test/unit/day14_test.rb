require 'test_helper'
require 'day14'

class Day14Test < Minitest::Test
  def test_day14a
    sut = Day14.new
    sut.load('data/day14a.txt')
    assert_equal(136, sut.part1)
  end

  def test_day14_part1
    sut = Day14.new
    sut.load('data/day14.txt')
    assert_equal(108_792, sut.part1)
  end
end
