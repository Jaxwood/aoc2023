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
    dfs(@start, visited, [])
    @current_longest
  end

  def longest_path_queue
    queue = Queue.new
    queue << [@start, Set.new([@start]), [@start]]

    until queue.empty?
      current, visited, path = queue.pop

      if current == @goal && path.length > @current_longest
        @current_longest = path.length - 1
      else
        next_positions = case [@forest_map[current], @dry]
                         when [:right, false]
                           [[current[0] + 1, current[1]]]
                         when [:down, false]
                           [[current[0], current[1] + 1]]
                         else
                           neighbors(current)
                         end

        next_positions.each do |next_pos|
          next unless @forest_map.key?(next_pos) && !visited.include?(next_pos) && @forest_map[next_pos] != :tree

          new_visited = visited.dup
          new_visited.add(next_pos)
          new_path = path.dup
          new_path << next_pos
          queue << [next_pos, new_visited, new_path]
        end
      end
    end

    @current_longest
  end

  private

  def dfs(current, visited, path)
    return unless @forest_map.key?(current) && !visited[current] && @forest_map[current] != :tree

    visited[current] = true
    path << current

    if current == @goal && path.length > @current_longest
      # initial tile is not counted
      @current_longest = path.length - 1
    else
      next_positions = case @forest_map[current]
                       when :right
                         [[current[0] + 1, current[1]]]
                       when :down
                         [[current[0], current[1] + 1]]
                       else
                         neighbors(current)
                       end

      next_positions.each do |next_pos|
        dfs(next_pos, visited, path)
      end
    end

    visited[current] = false
    path.pop
  end

  def neighbors(position)
    x, y = position
    [[x, y + 1], [x + 1, y], [x, y - 1], [x - 1, y]].select { |pos| @forest_map.key?(pos) }
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

  def find(token)
    @maze.each do |key, value|
      return key if value == token
    end
  end

  def part1
    start = find(:start)
    goal = find(:end)
    forest = Forest.new(@maze, start, goal)
    forest.find_longest_path
  end

  def part2
    start = find(:start)
    goal = find(:end)
    forest = Forest.new(@maze, start, goal)
    forest.longest_path_queue
  end
end
