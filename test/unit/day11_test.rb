# frozen_string_literal: true

require 'test_helper'
require 'day11'

class Day11Test < Minitest::Test
  def test_day11a
    sut = Day11.new
    sut.load('data/day11a.txt')
    assert_equal(374, sut.part1)
  end

  def test_day11_part1
    sut = Day11.new
    sut.load('data/day11.txt')
    assert_equal(9_521_550, sut.part1)
  end
end
