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
end
