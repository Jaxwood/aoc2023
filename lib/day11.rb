# frozen_string_literal: true

# Store information about the galaxies
class Space
  def initialize(map)
    @map = map
    @expanded_xs = []
    @expanded_ys = []

    x_max = map.keys.map(&:first).max
    (0..x_max).each do |x|
      @expanded_xs << x if @map.filter { |k, _v| k.first == x }.values.all? { |v| v == '.' }
    end

    y_max = map.keys.map(&:last).max
    (0..y_max).each do |y|
      @expanded_ys << y if @map.filter { |k, _v| k.last == y }.values.all? { |v| v == '.' }
    end
  end

  def galaxies
    galaxy = @map.select { |_k, v| v == '#' }.keys
    galaxy.combination(2).map { |a, b| manhattan_distance(a, b) }.sum
  end

  private

  def manhattan_distance(a, b)
    (a[0] - b[0]).abs + (a[1] - b[1]).abs + expanded_distance(a, b)
  end

  def expanded_distance(a, b)
    x_expanded = @expanded_xs.filter { |x| x.between?([a[0], b[0]].min, [a[0], b[0]].max) }.count
    y_expanded = @expanded_ys.filter { |y| y.between?([a[1], b[1]].min, [a[1], b[1]].max) }.count
    x_expanded + y_expanded
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
end
