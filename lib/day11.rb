# frozen_string_literal: true

# Store information about the galaxies
class Space
  def initialize(map, factor = 1)
    @map = map
    @factor = factor > 1 ? factor - 1 : factor
    @expanded_xs = expand_axis(:first)
    @expanded_ys = expand_axis(:last)
  end

  def galaxies
    galaxy = @map.select { |_k, v| v == '#' }.keys
    galaxy.combination(2).map { |a, b| manhattan_distance(a, b) }.sum
  end

  private

  def expand_axis(axis)
    max = @map.keys.map(&axis).max
    result = []
    (0..max).each do |value|
      result << value if @map.filter { |k, _v| k.send(axis) == value }.values.all? { |v| v == '.' }
    end
    result
  end

  def manhattan_distance(a, b)
    (a[0] - b[0]).abs + (a[1] - b[1]).abs + expanded_distance(a, b)
  end

  def expanded_distance(a, b)
    (@expanded_xs.filter { |x| x.between?([a[0], b[0]].min, [a[0], b[0]].max) }.count * @factor) +
      (@expanded_ys.filter { |y| y.between?([a[1], b[1]].min, [a[1], b[1]].max) }.count * @factor)
  end
end

# Day11
class Day11
  def load(file)
    @lines = File.readlines(file)
  end

  def parse
    map = {}
    @lines.each_with_index do |line, y|
      line.chomp.chars.each_with_index do |char, x|
        map[[x, y]] = char
      end
    end
    map
  end

  def part1
    Space.new(parse).galaxies
  end

  def part2(factor)
    Space.new(parse, factor).galaxies
  end
end
