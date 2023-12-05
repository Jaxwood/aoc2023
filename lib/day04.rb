# frozen_string_literal: true

class Day04
  def load(file)
    @lines = File.readlines(file)
  end

  def part1
    sum = 0
    @lines.each do |line|
      segments = line.split(':')
      numbers = segments[1].split('|')
      drawn = numbers[0].split(' ').map(&:to_i)
      winners = numbers[1].split(' ').map(&:to_i)
      matches = (Set.new(drawn) & Set.new(winners)).size
      sum += (matches - 1).times.reduce(1) { |acc, _| acc * 2 } if matches.positive?
    end
    sum
  end

  def part2
    cards = {}
    @lines.each do |line|
      segments = line.split(':')
      card = segments[0].split(' ')[1].to_i
      numbers = segments[1].split('|')
      drawn = numbers[0].split(' ').map(&:to_i)
      winners = numbers[1].split(' ').map(&:to_i)
      matches = (Set.new(drawn) & Set.new(winners)).size
      cards[card] = matches
    end

    iterations = 0
    queue = cards.map { |k, _| k }
    max = cards.max_by { |k, _| k }[0]
    while queue.size.positive?
      iterations += 1
      card = queue.shift
      (1..cards[card]).filter { |i| i <= max }.map { |i| card + i }.each { |c| queue << c } if cards[card].positive?
    end
    iterations
  end
end
