# frozen_string_literal: true

# Day13
class Day13
  def load(file)
    @maps = File.read(file).split("\n\n")
  end

  def parse
    result = []
    @maps.each do |valley|
      map = []
      valley.split("\n").each do |line|
        map << line.chars
      end
      result << map
    end
    result
  end

  def mirrors(valley, horizontal: false)
    width = valley[0].length - 1
    height = valley.length - 1
    result = []

    # for each row check if the candidate is valid
    0.upto(height) do |row|
      # no candidate found - exit
      break if row.positive? && result.empty?

      # add each column as a possible candidate for the first row
      candidates = row.zero? ? (1..width).to_a : result.dup
      result = []

      while candidates.any?
        valid = true
        column = candidates.shift
        idx = column
        previous_idx = column - 1
        while previous_idx >= 0 && idx <= width && valid
          valid = false if valley[row][previous_idx] != valley[row][idx]
          previous_idx -= 1
          idx += 1
        end

        result << column if valid
      end
    end

    return [] if result.empty?

    if horizontal
      result.map { |x| x * 100 }
    else
      result
    end
  end

  def smudge(grid)
    (grid.count - 1)
      .times
      .map do |y|
        left = grid[0..y].reverse
        right = grid[y + 1..]

        errors = left.zip(right).select(&:last).sum do |l, r|
          l.zip(r).count { _1 != _2 }
        end

        left.count if errors == 1
      end
      .compact
      .first
  end

  def part1
    total = 0
    valleys = parse
    valleys.each do |valley|
      result = mirrors(valley)
      result = mirrors(valley.transpose, horizontal: true) if result.empty?
      total += result.max if result.any?
    end
    total
  end

  def part2
    @maps
      .map do |pattern|
        grid = pattern.each_line.map(&:strip).map(&:chars)
        smudge(grid.transpose) || smudge(grid) * 100
      end
      .sum
  end
end
