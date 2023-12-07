# frozen_string_literal: true

require 'test_helper'
require 'day07'

class Day07Test < Minitest::Test
  def test_day07a
    sut = Day07.new
    sut.load('data/day07a.txt')
    assert_equal(6440, sut.part1)
  end

  def test_day07_part1
    sut = Day07.new
    sut.load('data/day07.txt')
    assert_equal(248_179_786, sut.part1)
  end
end
