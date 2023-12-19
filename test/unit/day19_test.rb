require 'test_helper'
require 'day19'

class Day19Test < Minitest::Test
  def test_day19a
    sut = Day19.new
    sut.load('data/day19a.txt')
    assert_equal(19_114, sut.part1)
  end

  def test_day19_part1
    sut = Day19.new
    sut.load('data/day19.txt')
    assert_equal(377_025, sut.part1)
  end
end
