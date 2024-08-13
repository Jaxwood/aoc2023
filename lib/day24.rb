# frozen_string_literal: true

require 'matrix'

class Point3D
  attr_reader :x, :y, :z, :cx, :cy, :cz

  def initialize(x, y, z, cx, cy, cz)
    @x, @y, @z = x.to_f, y.to_f, z.to_f
    @cx, @cy, @cz = cx.to_f, cy.to_f, cz.to_f
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
  return nil if points.size < 3

  a_rows = []
  b_elements = []

  3.times do |i|
    p1, p2 = points[i], points[(i+1) % 3]
    
    d = Vector[p2.cx - p1.cx, p2.cy - p1.cy, p2.cz - p1.cz]
    n = d.cross_product(Vector[p1.cx, p1.cy, p1.cz])
    
    a_rows << n.to_a
    b_elements << n.dot(Vector[p1.x, p1.y, p1.z])
  end

  a = Matrix.rows(a_rows)
  b = Vector.elements(b_elements)

  begin
    a.inverse * b
  rescue ExceptionForMatrix::ErrNotRegular
    return nil
  end
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
      return -1
    else
      return soluion[0] + solution[1] + solution[2]
    end
    0
  end
end

