# frozen_string_literal: true

# Day09
class Day09
  def load(file)
    @history = File.readlines(file).map { |line| line.split(' ') }.map { |line| line.map(&:to_i) }
  end

  def succ(line)
    return 0 if line.all?(&:zero?)

    difference = []
    line.each_cons(2) do |a, b|
      difference.push(b - a)
    end

    difference.last + succ(difference)
  end

  def pred(line)
    return 0 if line.all?(&:zero?)

    difference = []
    line.each_cons(2) do |a, b|
      difference.push(b - a)
    end

    line.first - pred(difference)
  end

  def part1
    @history.map { |line| line.last + succ(line) }.sum
  end

  def part2
    @history.map { |line| pred(line) }.sum
  end
end
