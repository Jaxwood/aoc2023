class Day04
  def load(file)
    @lines = File.readlines(file)
  end

  def part1
    sum = 0
    @lines.each do |line|
      segments = line.split(':')
      numbers = segments[1].split('|')
      drawn = numbers[0].split(' ').map(&:to_i)
      winners = numbers[1].split(' ').map(&:to_i)
      matches = (Set.new(drawn) & Set.new(winners)).size
      sum += (matches - 1).times.reduce(1) { |acc, _| acc * 2 } if matches.positive?
    end
    sum
  end
end
