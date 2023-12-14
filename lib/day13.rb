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

    return 0 if result.empty?

    if horizontal
      result.max * 100
    else
      result.max
    end
  end

  def part1
    total = 0
    valleys = parse
    valleys.each_with_index do |valley, _idx|
      sum = mirrors(valley)
      sum = mirrors(valley.transpose, horizontal: true) if sum.zero?
      total += sum
    end
    total
  end
end
