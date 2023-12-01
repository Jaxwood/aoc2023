class Day01
  def load(file)
    @lines = File.readlines(file)
  end

  def to_num(raw)
    case raw
    when "one" then 1
    when "two" then 2
    when "three" then 3
    when "four" then 4
    when "five" then 5
    when "six" then 6
    when "seven" then 7
    when "eight" then 8
    when "nine" then 9
    else raw.to_i
    end
  end

  def sum_line(line)
    nums = line.scan(/-?\d/).map(&:to_i)
    nums.first * 10 + nums.last
  end

  def sum_line_with_letters(line)
    nums = line.scan(/(?=(one|two|three|four|five|six|seven|eight|nine|\d))/).map {|n| to_num(n.first)}
    nums.first * 10 + nums.last
  end

  def part1
    sum = 0
    @lines.each {|line| sum += sum_line(line) }
    sum
  end

  def part2
    sum = 0
    @lines.each {|line| sum += sum_line_with_letters(line) }
    sum
  end
end
