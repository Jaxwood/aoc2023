# frozen_string_literal: true

require 'test_helper'
require 'day08'

class Day08Test < Minitest::Test
  def test_day08a
    sut = Day08.new
    sut.load('data/day08a.txt')
    assert_equal(2, sut.part1)
  end

  def test_day08b
    sut = Day08.new
    sut.load('data/day08b.txt')
    assert_equal(6, sut.part1)
  end

  def test_day08_part1
    sut = Day08.new
    sut.load('data/day08.txt')
    assert_equal(23_147, sut.part1)
  end
end
