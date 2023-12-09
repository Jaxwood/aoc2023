# frozen_string_literal: true

# Day09
class Day09
  def load(file)
    @history = File.readlines(file).map { |line| line.split(' ') }.map { |line| line.map(&:to_i) }
  end

  def succ(history)
    return 0 if history.all?(&:zero?)

    difference = []
    history.each_cons(2) do |a, b|
      difference.push(b - a)
    end

    difference.last + succ(difference)
  end

  def pred(history)
    return 0 if history.all?(&:zero?)

    difference = []
    history.each_cons(2) do |a, b|
      difference.push(b - a)
    end

    history.first - pred(difference)
  end

  def part1
    @history.map { |history| history.last + succ(history) }.sum
  end

  def part2
    @history.map { |history| pred(history) }.sum
  end
end
