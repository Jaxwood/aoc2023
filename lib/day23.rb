# frozen_string_literal: true

class Forest
  def initialize(forest_map, start, goal)
    @forest_map = forest_map
    @start = start
    @goal = goal
    @current_longest = 0
  end

  def find_longest_path
    visited = {}
    dfs(@start, visited, [@start])
    @current_longest
  end

  private

  def dfs(current, visited, path)
    return unless @forest_map.key?(current) && !visited[current] && @forest_map[current] != :tree

    visited[current] = true
    path << current

    if current == @goal && path.length > @current_longest
      @current_longest = path.length
    elsif @forest_map[current] == :right
      dfs([current[0] + 1, current[1]], visited, path)
    elsif @forest_map[current] == :down
      dfs([current[0], current[1] + 1], visited, path)
    else
      neighbors(current).each do |neighbor|
        dfs(neighbor, visited, path)
      end
    end
  end

  def neighbors(position)
    x, y = position
    [[x, y+1], [x+1, y], [x, y-1], [x-1, y]].select { |pos| @forest_map.key?(pos) }
  end
end

# Day23
class Day23
  def load(file)
    @visited = {}
    @maze = {}
    parts = { '#': :tree, '.': :empty, 'S': :start, 'E': :end, '>': :right, 'v': :down, '^': :up, '<': :left }
    content = File.read(file)
    @max_x = content.split("\n").map(&:size).max
    @max_y = content.split("\n").size
    content.split("\n").each_with_index do |line, y|
      line.chomp!
      line.split('').each_with_index do |part, x|
        @maze[[x, y]] = parts[part.to_sym]
      end
    end
  end

  def find_start
    @maze.each do |key, value|
      return key if value == :start
    end
  end

  def find_end
    @maze.each do |key, value|
      return key if value == :end
    end
  end

  def part1
    x, y = find_start
    gx, gy = find_end
    forest = Forest.new(@maze, [x, y], [gx, gy])
    forest.find_longest_path
  end
end
