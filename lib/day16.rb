# frozen_string_literal: true

# Day16
class Day16
  def load(file)
    lines = File.readlines(file)
    @map = {}
    lines.each_with_index do |line, y|
      line.chomp.chars.each_with_index do |char, x|
        @map[[x, y]] = char
      end
    end

    @direction_map = {
      ['/', :east] => [:north],
      ['/', :west] => [:south],
      ['/', :north] => [:east],
      ['/', :south] => [:west],
      ['\\', :east] => [:south],
      ['\\', :west] => [:north],
      ['\\', :north] => [:west],
      ['\\', :south] => [:east],
      ['.', :east] => [:east],
      ['.', :west] => [:west],
      ['.', :north] => [:north],
      ['.', :south] => [:south],
      ['-', :east] => [:east],
      ['-', :west] => [:west],
      ['-', :north] => %i[east west],
      ['-', :south] => %i[east west],
      ['|', :east] => %i[north south],
      ['|', :west] => %i[north south],
      ['|', :north] => [:north],
      ['|', :south] => [:south]
    }
  end

  def part1
    start = [0, 0]
    best = 0
    queue = [[start, @direction_map[[@map[start], :east]].first]]
    visited = Set.new
    iterations = 0

    while queue.any?
      iterations += 1
      ((x, y), direction) = queue.shift
      visited << [x, y]
      move = case direction
             when :east
               [x + 1, y]
             when :north
               [x, y - 1]
             when :south
               [x, y + 1]
             when :west
               [x - 1, y]
             else
               raise "Unexpected direction: #{direction}"
             end

      next unless @map.key?(move)

      @direction_map[[@map[move], direction]].each do |new_direction|
        queue << [move, new_direction]
      end

      next unless iterations % 1000000 == 0
      return best if best == visited.length
      best = visited.length
    end
    best
  end
end
