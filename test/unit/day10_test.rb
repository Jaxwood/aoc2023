# frozen_string_literal: true

require 'test_helper'
require 'day10'

class Day10Test < Minitest::Test
  def test_day10a
    sut = Day10.new
    sut.load('data/day10a.txt')
    assert_equal(4, sut.part1)
  end

  def test_day10b
    sut = Day10.new
    sut.load('data/day10b.txt')
    assert_equal(8, sut.part1)
  end

  def test_day10_part1
    sut = Day10.new
    sut.load('data/day10.txt')
    assert_equal(6778, sut.part1)
  end
end
