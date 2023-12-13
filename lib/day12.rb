# frozen_string_literal: true

# Day12
class Day12
  def initialize
    @cache = {}
  end

  def arrange(row, criteria)
    @cache["#{row}-#{criteria}"] ||= begin
      if criteria.empty?
        return 1 unless row.include?('#')

        return 0
      end

      return 0 if row.empty?

      next_character = row.first
      next_criteria = criteria.first
      result = 0

      case next_character
      when '#'
        result = pound(row, criteria, next_criteria)
      when '.'
        result = dot(row, criteria)
      when '?'
        result = dot(row, criteria) + pound(row, criteria, next_criteria)
      else
        raise "Unknown character #{next_character}"
      end

      result
    end
  end

  def pound(row, criteria, criterion)
    current = row[0, criterion].join
    current = current.gsub('?', '#')

    return 0 if current != ('#' * criterion)

    if row.length == criterion
      return 1 if criteria.length == 1

      return 0
    end

    return arrange(row[criterion + 1..], criteria[1..]) if row[criterion].include?('?') || row[criterion].include?('.')

    0
  end

  def dot(row, criteria)
    arrange(row[1..], criteria)
  end

  def load(file)
    @lines = File.readlines(file)
  end

  def parse
    springs = []
    @lines.each do |line|
      segments = line.split(' ')
      springs << [segments[0], segments[1].split(',').map(&:to_i)]
    end
    springs
  end

  def part1
    sum = 0
    parse.map do |spring|
      sum += arrange(spring[0].chars, spring[1])
    end
    sum
  end

  def part2
    sum = 0
    parse.map do |spring|
      sum += arrange(("#{spring[0]}?" * 5).chop.chars, spring[1] * 5)
    end
    sum
  end
end
