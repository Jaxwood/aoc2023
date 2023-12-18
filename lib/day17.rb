# frozen_string_literal: true

# The state of the search
class State
  attr_reader :x, :y, :dx, :dy, :total, :moves

  def initialize(pos, relative, moves, total)
    @x = pos[0]
    @y = pos[1]
    @dx = relative[0]
    @dy = relative[1]

    @moves = moves
    @total = total
  end

  def done?(finish)
    @x == finish[0] && @y == finish[1]
  end

  def coord
    [@x, @y]
  end

  def move(map, relative, min, max)
    (x, y) = relative
    to = [@x + x, @y + y]

    # Can't move to the origin
    return nil if [@dx + x, @dy + y] == [0, 0]

    # limit of 3 moves on a line
    moves = 1
    if relative == [@dx, @dy]
      moves = @moves + 1
    elsif moves < min
      return nil
    end
    return nil if moves > max

    State.new(to, relative, moves, @total + map.fetch(to, 0))
  end

  def hash
    [@x, @y, @dx, @dy, @moves].hash
  end

  def eql?(other)
    @x == other.x &&
      @y == other.y &&
      @dx == other.dx &&
      @dy == other.dy &&
      @moves == other.moves
  end
end

# Day17
class Day17
  def load(file)
    @lines = File.readlines(file)
    @map = {}
    @lines.each_with_index do |line, y|
      line.chomp.each_char.with_index do |char, x|
        @map[[x, y]] = char.to_i
      end
    end
  end

  def next_moves(state, min, max)
    [[0, 1], [0, -1], [1, 0], [-1, 0]]
      .map { |pos| state.move(@map, pos, min, max) }
      .compact
      .filter { |m| @map.key?(m.coord) }
  end

  def part1(min, max)
    start = State.new([0, 0], [0, 0], 0, 0)
    finish = [@map.keys.max_by { |k| k[0] }[0], @map.keys.max_by { |k| k[1] }[1]]

    queue = [start]
    visited = Set.new

    while queue.any?
      current = queue.sort_by!(&:total).shift
      return current.total if current.done?(finish)

      moves = next_moves(current, min, max)

      moves.each do |move|
        queue << move unless visited.include?(move)
        visited.add(move)
      end
    end
    0
  end
end
