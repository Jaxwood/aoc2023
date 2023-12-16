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

  def part1(start, facing)
    best = 0
    iterations = 0
    visited = Set.new([[start, facing]])
    queue = []

    @direction_map[[@map[start], facing]].each do |direction|
      queue << [start, direction]
    end

    while queue.any?
      iterations += 1
      ((x, y), direction) = queue.shift
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
        if !visited.include?([move, new_direction])
          queue << [move, new_direction]
          visited << [move, new_direction]
        end
      end
    end

    visited.map(&:first).uniq.count
  end

  def part2
    best = 0
    max_x = @map.keys.map(&:first).max
    max_y = @map.keys.map(&:last).max
    queue = []

    max_x.times do |x|
      queue << [[x, 0], :south]
      queue << [[x, max_y], :north]
    end

    max_y.times do |y|
      queue << [[0, y], :east]
      queue << [[max_x, y], :west]
    end

    while queue.any?
      ((x, y), direction) = queue.shift
      best = [best, part1([x, y], direction)].max
    end

    best
  end
end
