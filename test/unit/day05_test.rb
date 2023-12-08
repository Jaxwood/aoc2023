# frozen_string_literal: true

require 'test_helper'
require 'day05'

class Day05Test < Minitest::Test
  def test_day05a
    sut = Day05.new
    assert_equal(35, sut.part1('data/day05a.txt'))
  end

  def test_day05b
    sut = Day05.new
    assert_equal(46, sut.part2('data/day05a.txt'))
  end

  def test_range_end
    sut = 1...5
    assert_equal(1, sut.begin)
    assert_equal(5, sut.end)
  end

  def test_range_include
    sut = 1...5
    assert_equal(true, sut.include?(sut.begin))
    assert_equal(false, sut.include?(sut.end))
  end

  def test_rule_subset
    sut = Rule.new(0, 2, 2) # 2,3

    assert_equal(true, sut.subset?(2...4))
    assert_equal(false, sut.subset?(0...2))
    assert_equal(false, sut.subset?(4...6))
  end

  def test_rule_superset
    sut = Rule.new(0, 2, 5) # 2,3,4,5,6

    assert_equal(true, sut.superset?(2...7))
    assert_equal(false, sut.superset?(1...7))
    assert_equal(false, sut.superset?(2...8))
  end

  def test_rule_overlaps
    sut = Rule.new(0, 2, 4) # 2,3,4,5

    assert_equal(true, sut.overlaps?(1...3))
    assert_equal(true, sut.overlaps?(4...6))
    assert_equal(false, sut.overlaps?(1...2))
    assert_equal(false, sut.overlaps?(6...7))
  end

  def test_rule_split
    sut = Rule.new(20, 5, 10) # 5,6,7,8,9,10,11,12,13,14

    assert_equal([1...5, 20...25], sut.split(1...10)) # 1,2,3,4;5,6,7,8,9
    assert_equal([25...30, 15...20], sut.split(10...20)) # 10,11,12,13,14;15,16,17,18,19
    assert_equal([1...5, 20...30, 15...20], sut.split(1...20)) # 1,2,3,4;5,6,7,8,9;10,11,12,13,14;15,16,17,18,19
  end

  def test_day05_part1
    sut = Day05.new
    assert_equal(382_895_070, sut.part1('data/day05.txt'))
  end

  def _test_day05_part2
    sut = Day05.new
    assert_equal(17_729_182, sut.part2('data/day05.txt'))
  end
end
