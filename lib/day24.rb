# frozen_string_literal: true

class Line
  attr_reader :slope, :y_intercept, :x, :y

  def initialize(x, y, cx, cy)
    @x = x
    @y = y
    if cx == 0
      @slope = Float::INFINITY
      @x_intercept = x
    else
      @slope = cy.to_f / cx
      @y_intercept = y - @slope * x
    end
  end

  def intersects_with?(other_line)
    return false if @slope == other_line.slope && @slope != Float::INFINITY
    return false if @slope == Float::INFINITY && other_line.slope == Float::INFINITY && @x_intercept != other_line.x_intercept
    true
  end

  def intersection_point(other_line)
    return [0, 0] unless intersects_with?(other_line)

    if @slope == Float::INFINITY
      x = @x_intercept
      y = other_line.slope * x + other_line.y_intercept
    elsif other_line.slope == Float::INFINITY
      x = other_line.x_intercept
      y = @slope * x + @y_intercept
    else
      x = (other_line.y_intercept - @y_intercept) / (@slope - other_line.slope)
      y = @slope * x + @y_intercept
    end

    [x, y]
  end

  def to_s
    "(#{@x}, #{@y})"
  end

  protected

  def x_intercept
    @x_intercept
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

  def part1
    result = []
    @parts.each_with_index do |part, i|
      for j in (i + 1)..(@parts.length - 1)
        other_part = @parts[j]

        if part.intersects_with?(other_part)
          x, y = part.intersection_point(other_part)
          # check if the intersection point is in the test grid
          if x.between?(@min, @max) && y.between?(@min, @max)
            puts "Intersection point: #{x}, #{y} for lines #{part} and #{other_part}"
            result << part.intersection_point(other_part)
          end
        end
      end
    end
    result.length
  end
end
