# frozen_string_literal: true

# Day09
class Day09
  def load(file)
    @history = File.readlines(file).map { |line| line.split(' ') }.map { |line| line.map(&:to_i) }
  end

  def diff(line)
    return 0 if line.all?(&:zero?)

    difference = []
    line.each_cons(2) do |a, b|
      difference.push(b - a)
    end

    difference.last + diff(difference)
  end

  def part1
    @history.map { |line| line.last + diff(line) }.sum
  end
end
