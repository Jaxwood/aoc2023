class Day03
  private

  def parse(_line)
    map = {}
    for y in 0..@lines.length - 1
      for x in 0..@lines[y].length - 2
        map[[x, y]] = @lines[y][x]
      end
    end
    map
  end

  def parse_number(map, from, to, y)
    num = ''
    for x in from..to
      num += map[[x, y]]
    end
    num.to_i
  end

  def valid_char?(candidate)
    candidate != '.' and !candidate.match?(/\d/)
  end

  def is_valid?(map, from, to, y)
    # check if next to the number
    return true if map.key?([from - 1, y]) && valid_char?(map[[from - 1, y]])

    return true if map.key?([to + 1, y]) && valid_char?(map[[to + 1, y]])

    for x in from..to
      for n in @neighbors
        next unless map.key?([x + n[0], y + n[1]])

        next unless y + n[1] != y
        return true if valid_char?(map[[x + n[0], y + n[1]]])
      end
    end
    false
  end

  def boundary(map, candidate)
    from = candidate[0]
    to = candidate[0]
    y = candidate[1]
    from -= 1 while map.key?([from - 1, y]) and map[[from - 1, y]].match?(/\d/)
    to += 1 while map.key?([to + 1, y]) and map[[to + 1, y]].match?(/\d/)
    [from, to]
  end

  public

  def load(file)
    @lines = File.readlines(file)
    @neighbors = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
  end

  def part1
    map = parse(@lines)
    nums = []
    for y in 0..@lines.length - 1
      from = nil
      for x in 0..@lines[y].length - 2
        if map[[x, y]].match?(/\d/)
          # set start of number
          from = x if from.nil?
          # check if end of line and parse number
          if x == @lines[y].length - 2 && is_valid?(map, from, x - 1, y)
            nums << parse_number(map, from, x, y)
            from = nil
          end
        elsif !from.nil?
          # parse number
          nums << parse_number(map, from, x - 1, y) if is_valid?(map, from, x - 1, y)
          from = nil
        end
      end
    end
    nums.sum
  end

  def part2
    map = parse(@lines)
    stars = []
    for y in 0..@lines.length - 1
      for x in 0..@lines[y].length - 2
        stars << [x, y] if map[[x, y]] == '*'
      end
    end

    sum = 0
    for star in stars
      # using a set can potentially fail if two numbers next to each other
      # have the same value. This is not the case in my input data.
      nums = Set.new
      for n in @neighbors
        candidate = [star[0] + n[0], star[1] + n[1]]
        next unless map.key?(candidate)

        if map[candidate].match?(/\d/)
          num = boundary(map, candidate)
          nums.add(parse_number(map, num[0], num[1], star[1] + n[1]))
        end
      end
      sum += nums.reduce(:*) if nums.length == 2
    end
    sum
  end
end
