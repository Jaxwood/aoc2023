# frozen_string_literal: true

# Day14
class Day14
  def load(file)
    @maps = File.read(file).split("\n")
  end

  def parse
    map = {}
    @maps.each_with_index do |line, y|
      line.chars.each_with_index do |c, x|
        map[[x, y]] = c
      end
    end
    map
  end

  def tilt(map, direction)
    case direction
    when :north
      width = map.keys.max_by(&:first).first
      height = map.keys.max_by(&:last).last
      (0..width).each do |x|
        (0..height).each do |y|
          if map[[x, y]] == 'O'
            map[[x, y]] = '.'
            while y >= 0
              y -= 1
              if map[[x, y]] == '.'
                next
              else
                map[[x, y + 1]] = 'O'
                break
              end
            end
          end
        end
      end
    else
      raise "Unknown direction #{direction}"
    end
    map
  end

  def weight(map)
    sum = 0
    height = map.keys.max_by(&:last).last + 1
    width = map.keys.max_by(&:first).first
    (0..width).sum do |x|
      (0..height).sum do |y|
        sum += map[[x, y]] == 'O' ? height - y : 0
      end
    end
    sum
  end

  def part1
    map = parse
    new_map = tilt(map, direction = :north)
    weight(new_map)
  end
end
