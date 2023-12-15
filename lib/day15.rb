# frozen_string_literal: true

require 'base64'

# Day15
class Day15
  def load(file)
    @sequence = File.read(file).split(',').map(&:strip)
  end

  def part1
    results = []
    @sequence.each do |s|
      val = 0
      s.chars.each do |c|
        val = ((val + c.ord) * 17) % 256
      end
      results.push(val)
    end
    results.sum
  end
end
