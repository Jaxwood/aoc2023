# frozen_string_literal: true
#
class Line
  attr_reader :slope, :y_intercept

  def initialize(x, y, z, cx, cy, cz)
    # Calculate the slope
    @slope = cy.to_f / cx if cx != 0
    @slope ||= Float::INFINITY # Vertical line

    # Calculate the y-intercept
    if @slope == Float::INFINITY
      @x_intercept = x
    else
      @y_intercept = y - @slope * x
    end
  end

  def intersects_with?(other_line)
    # If slopes are equal, lines are parallel (or identical)
    return false if @slope == other_line.slope

    true
  end

  def intersection_point(other_line)
    return nil unless intersects_with?(other_line)

    x = (other_line.y_intercept - @y_intercept) / (@slope - other_line.slope)
    y = @slope * x + @y_intercept

    [x, y]
  end

  def to_s
    if @slope == Float::INFINITY
      "x = #{@x_intercept}"
    else
      "y = #{@slope}x + #{@y_intercept}"
    end
  end
end

# Day24
class Day24
  def load(file)
    content = File.read(file)
    @parts = []
    content.split("\n").each do |line|
      f, e = line.split("@")
      fs = f.split(",").map(&:to_i)
      es = e.split(",").map(&:to_i)
      @parts << Line.new(fs[0], fs[1], fs[2], es[0], es[1], es[2])
    end
  end

  def part1
    puts @parts[0].intersection_point(@parts[1])
    sum = 0
    sum
  end
end
