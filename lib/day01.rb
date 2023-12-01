class Day01
  def load(file)
    @lines = File.readlines(file)
  end

  def sum_line(line)
    nums = line.scan(/-?\d/).map(&:to_i)
    nums.first * 10 + nums.last
  end

  def part1
    sum = 0
    @lines.each {|line| sum += sum_line(line) }
    sum
  end
end
