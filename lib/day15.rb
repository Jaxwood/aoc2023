# frozen_string_literal: true

require 'base64'

# Day15
class Day15
  def load(file)
    @sequence = File.read(file).split(',').map(&:strip)
  end

  def box_no(candidate)
    val = 0
    candidate.chars.each do |c|
      val = ((val + c.ord) * 17) % 256
    end
    val
  end

  def part1
    results = []
    @sequence.each do |s|
      results.push(box_no(s))
    end
    results.sum
  end
end
