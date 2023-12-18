# frozen_string_literal: true

# Day18
class Day18
  def load(file)
    @plan = []
    @lines = File.readlines(file)
    @lines.each do |line|
      segments = line.split(' ')
      @plan << [segments[0].to_sym, segments[1].to_i, segments[2][1..-2]]
    end
  end

  def fill(dig)
    queue = [[1, 1]]
    visited = Set.new
    while queue.any?
      cursor = queue.shift
      dig[cursor] = 'O'
      neighbors = [[cursor[0], cursor[1] - 1], [cursor[0], cursor[1] + 1], [cursor[0] - 1, cursor[1]],
                   [cursor[0] + 1, cursor[1]]]
      neighbors.each do |n|
        queue << n unless dig[n] || visited.include?(n)
        visited.add(n)
      end
    end
  end

  # area of a polygon
  def area(coordinates)
    n = coordinates.length
    area = 0
    perimeter = 0

    (0..n - 1).each do |i|
      x1, y1 = coordinates[i]
      x2, y2 = coordinates[(i + 1) % n]

      area += (x1 * y2 - x2 * y1)
      perimeter += Math.sqrt((x2 - x1)**2 + (y2 - y1)**2)
    end

    area = area.abs / 2.0
    (area + (perimeter / 2.0) + 1).to_i
  end

  def part1
    dig = {}
    cursor = [0, 0]
    @plan.each do |cmd|
      case cmd[0]
      when :D
        cmd[1].times do
          dig[cursor.dup] = cmd[2]
          cursor[1] += 1
        end
      when :U
        cmd[1].times do
          dig[cursor.dup] = cmd[2]
          cursor[1] -= 1
        end
      when :L
        cmd[1].times do
          dig[cursor.dup] = cmd[2]
          cursor[0] -= 1
        end
      when :R
        cmd[1].times do
          dig[cursor.dup] = cmd[2]
          cursor[0] += 1
        end
      else
        raise "Unknown command #{cmd[0]}"
      end
    end
    fill(dig)
    dig.keys.count
  end

  def part2
    coords = [[0, 0]]
    @lines.each do |line|
      segments = line.split(' ')
      size = segments[2][2..-3].hex.to_i
      direction = segments[2][2..-2][-1].to_i
      coords << case direction
                when 0 # right
                  cursor = coords[-1]
                  [cursor[0] + size, cursor[1]]
                when 1 # down
                  cursor = coords[-1]
                  [cursor[0], cursor[1] + size]
                when 2 # left
                  cursor = coords[-1]
                  [cursor[0] - size, cursor[1]]
                when 3 # up
                  cursor = coords[-1]
                  [cursor[0], cursor[1] - size]
                else
                  raise "Unknown direction #{direction}"
                end
    end
    area(coords)
  end
end
