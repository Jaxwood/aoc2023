# frozen_string_literal: true

require 'test_helper'
require 'day06'

class Day06Test < Minitest::Test
  def test_day06a
    sut = Day06.new
    assert_equal(288, sut.part1('data/day06a.txt'))
  end

  def test_day06_part1
    sut = Day06.new
    assert_equal(2374848, sut.part1('data/day06.txt'))
  end
end
