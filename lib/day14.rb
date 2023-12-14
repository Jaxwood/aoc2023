# frozen_string_literal: true

require 'base64'

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
    width = map.keys.max_by(&:first).first
    height = map.keys.max_by(&:last).last

    case direction
    when :north
      (0..width).each do |x|
        (0..height).each do |y|
          next unless map[[x, y]] == 'O'

          map[[x, y]] = '.'
          yy = y
          while yy >= 0
            yy -= 1
            next if map[[x, yy]] == '.'

            map[[x, yy + 1]] = 'O'
            break
          end
        end
      end
    when :west
      (0..width).each do |x|
        (0..height).each do |y|
          next unless map[[x, y]] == 'O'

          map[[x, y]] = '.'
          xx = x
          while xx >= 0
            xx -= 1
            next if map[[xx, y]] == '.'

            map[[xx + 1, y]] = 'O'
            break

          end
        end
      end
    when :south
      (0..width).each do |x|
        height.downto(0).each do |y|
          next unless map[[x, y]] == 'O'

          map[[x, y]] = '.'
          yy = y
          while yy <= height
            yy += 1
            next if map[[x, yy]] == '.'

            map[[x, yy - 1]] = 'O'
            break
          end
        end
      end
    when :east
      width.downto(0).each do |x|
        (0..height).each do |y|
          next unless map[[x, y]] == 'O'

          map[[x, y]] = '.'
          xx = x
          while xx <= width
            xx += 1
            next if map[[xx, y]] == '.'

            map[[xx - 1, y]] = 'O'
            break
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

  def key(map)
    key = ''
    width = map.keys.max_by(&:first).first
    height = map.keys.max_by(&:last).last
    (0..width).map do |x|
      (0..height).map do |y|
        key += map[[x, y]]
      end
    end
    Base64.encode64(key)
  end

  def draw(map)
    puts
    width = map.keys.max_by(&:first).first
    height = map.keys.max_by(&:last).last
    (0..height).each do |y|
      (0..width).each do |x|
        print map[[x, y]]
      end
      puts
    end
  end

  def part1
    map = parse
    map = tilt(map, direction = :north)
    weight(map)
  end

  def part2
    map = parse

    cycles = 0
    cycle_key = ''
    cycle_found = false

    cache = {}
    keys = []

    break_at = 1_000_000_000

    loop do
      cycles += 1

      %i[north west south east].each do |direction|
        map = tilt(map, direction)
      end

      # look for a cycle
      key = key(map)
      if cache[key]
        cycle_key = key if cycle_key == ''
        keys.push(cycles) if key == cycle_key
      end
      cache[key] = true

      # cycle found - find next cycle
      if keys.size == 2 && !cycle_found
        cycle = keys[1] - keys[0]
        offset = keys[0] - cycle
        break_at = cycle + offset + ((1_000_000_000 - offset) % cycle) + cycle
        cycle_found = true
      end

      break if cycles == break_at
    end

    weight(map)
  end
end
