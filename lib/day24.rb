# frozen_string_literal: true

require 'matrix'

class Point3D
  attr_reader :x, :y, :z, :cx, :cy, :cz

  def initialize(x, y, z, cx, cy, cz)
    @x, @y, @z = x, y, z
    @cx, @cy, @cz = cx, cy, cz
  end

  def to_s
    "Position: (#{x}, #{y}, #{z}), Velocity: (#{cx}, #{cy}, #{cz})"
  end
end

class Line
  attr_reader :x, :y, :cx, :cy

  def initialize(x, y, cx, cy)
    @x = x.to_f
    @y = y.to_f
    @cx = cx.to_f
    @cy = cy.to_f
  end

  def intersects_forward?(other_line)
    # Calculate the intersection point
    denominator = (@cx * other_line.cy - @cy * other_line.cx)
    return false if denominator == 0 # Lines are parallel

    t = ((other_line.x - @x) * other_line.cy + (y - other_line.y) * other_line.cx) / denominator
    u = ((other_line.x - @x) * @cy + (y - other_line.y) * @cx) / denominator

    # Check if intersection occurs in the future for both lines
    t > 0 && u > 0
  end

  def intersection_point(other_line)
    denominator = (@cx * other_line.cy - @cy * other_line.cx)
    return nil if denominator == 0 # Lines are parallel

    t = ((other_line.x - @x) * other_line.cy + (y - other_line.y) * other_line.cx) / denominator

    return nil unless t > 0 # Intersection is in the past

    intersection_x = @x + t * @cx
    intersection_y = @y + t * @cy

    [intersection_x, intersection_y]
  end
end

def find_intersection_point(points)
  a = Matrix.build(6, 6) { 0 }
  b = Vector.elements(Array.new(6, 0))

  4.times do |i|
    h1, h2 = points[i], points[i+1]
    a[i, 0], a[i, 1], a[i, 2] = h2.cy - h1.cy, h1.cx - h2.cx, 0
    a[i, 3], a[i, 4], a[i, 5] = h1.y - h2.y, h2.x - h1.x, 0
    b[i] = h2.x * h2.cy - h2.y * h2.cx - h1.x * h1.cy + h1.y * h1.cx

    a[i+2, 0], a[i+2, 1], a[i+2, 2] = h2.cz - h1.cz, 0, h1.cx - h2.cx
    a[i+2, 3], a[i+2, 4], a[i+2, 5] = h1.z - h2.z, 0, h2.x - h1.x
    b[i+2] = h2.x * h2.cz - h2.z * h2.cx - h1.x * h1.cz + h1.z * h1.cx
  end

  a.inverse * b
end

# Day24
class Day24
  def load(file, min, max)
    content = File.read(file)
    @min = min
    @max = max
    @parts = []
    content.split("\n").each do |line|
      f, e = line.split("@")
      fs = f.split(",").map(&:to_i)
      es = e.split(",").map(&:to_i)
      @parts << Line.new(fs[0], fs[1], es[0], es[1])
    end
  end

  def parse(file)
    content = File.read(file)
    @parts = []
    content.split("\n").each do |line|
      f, e = line.split("@")
      fs = f.split(",").map(&:to_i)
      es = e.split(",").map(&:to_i)
      @parts << Point3D.new(fs[0], fs[1], fs[2], es[0], es[1], es[2])
    end
  end

  def part1
    result = []
    @parts.each_with_index do |part, i|
      for j in (i + 1)..(@parts.length - 1)
        other_part = @parts[j]

        if part.intersects_forward?(other_part)
          x, y = part.intersection_point(other_part)
          # check if the intersection point is in the test grid
          if x.between?(@min, @max) && y.between?(@min, @max)
            result << [x, y]
          end
        end
      end
    end
    result.length
  end

  def part2
    solution = find_intersection_point(@parts)
    if solution.nil?
      -1
    else
      solution[0] + solution[1] + solution[2]
    end
  end
end

