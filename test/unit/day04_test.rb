# frozen_string_literal: true

require 'day04'

class Day01Test < Minitest::Test
  def test_day04a
    sut = Day04.new
    sut.load('data/day04a.txt')
    assert_equal(13, sut.part1)
  end

  def test_day04b
    sut = Day04.new
    sut.load('data/day04a.txt')
    assert_equal(30, sut.part2)
  end

  def test_day04_part1
    sut = Day04.new
    sut.load('data/day04.txt')
    assert_equal(20_107, sut.part1)
  end

  def test_day04_part2
    sut = Day04.new
    sut.load('data/day04.txt')
    assert_equal(8_172_507, sut.part2)
  end
end
