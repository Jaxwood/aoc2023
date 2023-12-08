# frozen_string_literal: true

# Day08
class Day08
  def load(file)
    @lines = File.readlines(file)
  end

  def parse
    map = {}
    @lines[2..].each do |line|
      line = line.chomp.split('=')
      map[line[0].strip] = line[1].split(',').map { |x| x.delete('(').delete(')').strip }
    end
    map
  end

  def part1
    instructions = @lines[0].chomp.chars
    map = parse

    from = 'AAA'
    to = 'ZZZ'
    iterations = 0
    idx = 0

    loop do
      turn = if instructions[idx] == 'L'
               0
             else
               1
             end
      from = map[from][turn]
      iterations += 1
      idx = (idx + 1) % instructions.length
      break if from == to
    end

    iterations
  end

  def part2
    instructions = @lines[0].chomp.chars
    map = parse

    starts = map.keys.filter { |x| x.chars.last == 'A' }
    done = {}

    starts.each do |f|
      idx = 0
      from = f
      iterations = 0
      loop do
        turn = if instructions[idx] == 'L'
                 0
               else
                 1
               end

        from = map[from][turn]
        iterations += 1
        idx = (idx + 1) % instructions.length
        break if from.chars.last == 'Z'
      end
      done[f] = iterations
    end

    done.values.reduce(:lcm)
  end
end
