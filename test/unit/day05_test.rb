# frozen_string_literal: true

require 'test_helper'
require 'day05'

class Day05Test < Minitest::Test
  def test_day05a
    sut = Day05.new
    assert_equal(35, sut.part1('data/day05a.txt'))
  end

  def _test_day05b
    sut = Day05.new
    assert_equal(46, sut.part2('data/day05a.txt'))
  end

  def test_day05_part1
    sut = Day05.new
    assert_equal(382_895_070, sut.part1('data/day05.txt'))
  end

  def test_day05_part2
    sut = Day05.new
    assert_equal(17_729_182, sut.part2('data/day05.txt'))
  end
end
