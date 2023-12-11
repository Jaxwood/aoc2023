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

  def test_day10c
    sut = Day10.new
    sut.load('data/day10c.txt')
    assert_equal(4, sut.part2)
  end

  def test_day10d
    sut = Day10.new
    sut.load('data/day10d.txt')
    assert_equal(4, sut.part2)
  end

  def test_day10e
    sut = Day10.new
    sut.load('data/day10e.txt')
    assert_equal(8, sut.part2)
  end

  def test_day10f
    sut = Day10.new
    sut.load('data/day10f.txt')
    assert_equal(10, sut.part2)
  end

  def test_day10_part1
    sut = Day10.new
    sut.load('data/day10.txt')
    assert_equal(6778, sut.part1)
  end

  def test_day10_part2
    sut = Day10.new
    sut.load('data/day10.txt')
    assert_equal(433, sut.part2)
  end
end
