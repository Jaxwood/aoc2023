# frozen_string_literal: true

# Encapsulate navigation
class Navigator
  def initialize(map)
    @map = map
  end

  def route
    position = @map.key('S')
    visited = Set.new([position])
    mutate_start(position)
    queue = [find_next_move(position)]

    # visit every node in the loop
    while queue.any?
      candidates = queue.shift

      candidates.each do |candidate|
        next if visited.include?(candidate)

        visited.add(candidate)
        queue.push(find_next_move(candidate))
      end
    end

    visited
  end

  private

  def neighbors(position)
    [[position[0], position[1] - 1], [position[0], position[1] + 1],
     [position[0] - 1, position[1]], [position[0] + 1, position[1]]]
  end

  def mutate_start(position)
    north, south, west, east = neighbors(position)

    possible_moves = [north, south, east, west].filter { |neighbor| @map.key?(neighbor) }
                                               .filter { |neighbor| @map[neighbor] != '.' }
                                               .filter { |neighbor| find_next_move(neighbor).include?(position) }

    if possible_moves.include?(north) && possible_moves.include?(west)
      @map[position] = 'J'
    elsif possible_moves.include?(north) && possible_moves.include?(east)
      @map[position] = 'L'
    elsif possible_moves.include?(west) && possible_moves.include?(south)
      @map[position] = '7'
    elsif possible_moves.include?(south) && possible_moves.include?(east)
      @map[position] = 'F'
    elsif possible_moves.include?(south) && possible_moves.include?(north)
      @map[position] = '|'
    elsif possible_moves.include?(east) && possible_moves.include?(west)
      @map[position] = '-'
    else
      raise('Unexpected pattern')
    end
  end

  def find_next_move(position)
    north, south, west, east = neighbors(position)

    current = @map[position]
    result = case current
             when '|' # north or south
               return [north, south]
             when '-' # east or west
               return [east, west]
             when 'J' # north or west
               return [north, west]
             when 'L' # north or east
               return [north, east]
             when '7' # south or west
               return [south, west]
             when 'F' # south or east
               return [south, east]
             else
               []
             end

    raise("Expected 2 neighbors, got #{result.length}") if result.length != 2

    result
  end
end

# Day10
class Day10
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
    Navigator.new(parse).route.length / 2
  end

  def part2
    route = Navigator.new(parse).route
    tiles = ['J', '|', 'L']
    result = 0
    @lines.each_with_index do |line, y|
      open = false
      line.chomp.chars.each_with_index do |char, x|
        if route.include?([x, y])
          open = !open if tiles.include?(char)
        elsif open
          result += 1
        end
      end
    end
    result
  end
end
