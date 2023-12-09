# frozen_string_literal: true

require 'test_helper'
require 'day09'

class Day09Test < Minitest::Test
  def test_day09a
    sut = Day09.new
    sut.load('data/day09a.txt')
    assert_equal(114, sut.part1)
  end

  def test_day09b
    sut = Day09.new
    sut.load('data/day09a.txt')
    assert_equal(2, sut.part2)
  end

  def test_day09_part1
    sut = Day09.new
    sut.load('data/day09.txt')
    assert_equal(1_684_566_095, sut.part1)
  end

  def test_day09_part2
    sut = Day09.new
    sut.load('data/day09.txt')
    assert_equal(1136, sut.part2)
  end
end
