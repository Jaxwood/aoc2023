# frozen_string_literal: true

require 'test_helper'
require 'day06'

class Day06Test < Minitest::Test
  def test_day06a
    sut = Day06.new
    assert_equal(288, sut.part1('data/day06a.txt'))
  end

  def test_day06b
    sut = Day06.new
    assert_equal(71_503, sut.part2([71_530, 940_200]))
  end

  def test_day06_part1
    sut = Day06.new
    assert_equal(2_374_848, sut.part1('data/day06.txt'))
  end

  def test_day06_part2
    sut = Day06.new
    assert_equal(39132886, sut.part2([55_999_793, 401_148_522_741_405]))
  end
end
