# frozen_string_literal: true

class Day06
  def parse(filename)
    times = []
    distances = []
    result = []
    File.open(filename, 'r') do |file|
      times = file.readline.scan(/\d+/).map(&:to_i)
      distances = file.readline.scan(/\d+/).map(&:to_i)
    end
    times.each_with_index do |time, index|
      result << [time, distances[index]]
    end
    result
  end

  def part1(filename)
    races = parse(filename)
    winners = []

    races.each do |race|
      time = race[0]
      distance = race[1]
      total = 0
      time.times do |second|
        total += 1 if (second * (time - second)) > distance
      end
      winners << total
    end

    winners.reduce(1, :*)
  end

  def part2(race)
    time = race[0]
    distance = race[1]
    total = 0
    time.times do |second|
      total += 1 if (second * (time - second)) > distance
    end
    total
  end
end
