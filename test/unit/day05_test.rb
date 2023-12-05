# frozen_string_literal: true

require 'test_helper'
require 'day05'

class Day01Test < Minitest::Test
  def test_day05a
    sut = Day05.new
    sut.load('data/day05a.txt')
    assert_equal(35, sut.part1)
  end
end
