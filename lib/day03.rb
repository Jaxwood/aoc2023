class Day03
  def load(file)
    @lines = File.readlines(file)
    @neighbors = [[1,0], [-1,0], [0,1], [0,-1], [1,1], [-1,-1], [1,-1], [-1,1]]
  end

  def parse(line)
    map = {}
    for y in 0..@lines.length-1
      for x in 0..@lines[y].length-2
        map[[x,y]] = @lines[y][x]
      end
    end
    map
  end

  def parse_number(map, from, to, y)
    num = ""
    for x in from..to
      num += map[[x,y]]
    end
    num.to_i
  end

  def valid_char?(candidate)
    candidate != "." and !candidate.match?(/\d/)
  end

  def is_valid?(map, from, to, y)
    # check if next to the number 
    if map.key?([from-1,y]) 
      if valid_char?(map[[from-1,y]])
        return true
      end
    end

    if map.key?([to+1,y])
      if valid_char?(map[[to+1,y]])
        return true
      end
    end

    for x in from..to
      for n in @neighbors
        if map.key?([x+n[0],y+n[1]])
          if y+n[1] != y
            if valid_char?(map[[x+n[0],y+n[1]]])
              return true
            end
          end
        end
      end
    end
    false
  end

  def boundary(map, candidate)
    from = candidate[0]
    to = candidate[0]
    y = candidate[1]
    while map.key?([from-1,y]) and map[[from-1,y]].match?(/\d/)
      from -= 1
    end
    while map.key?([to+1,y]) and map[[to+1,y]].match?(/\d/)
      to += 1
    end
    [from, to]
  end

  def part1
    map = parse(@lines)
    nums = []
    for y in 0..@lines.length-1
      from = nil
      for x in 0..@lines[y].length-2
        if map[[x,y]].match?(/\d/)
          # set start of number
          if from.nil?
            from = x
          end
          # check if end of line and parse number
          if x == @lines[y].length-2 
            if is_valid?(map, from, x - 1, y)
              nums << parse_number(map, from, x, y)
              from = nil
            end
          end
        else
          # parse number
          if not from.nil?
            if is_valid?(map, from, x - 1, y)
              nums << parse_number(map, from, x - 1, y)
            end
            from = nil
          end
        end
      end
    end
    nums.sum
  end

  def part2
    map = parse(@lines)
    stars = []
    for y in 0..@lines.length-1
      for x in 0..@lines[y].length-2
        if map[[x,y]] == "*"
          stars << [x,y]
        end
      end
    end

    sum = 0
    for star in stars
      # using a set can potentially fail if two numbers next to each other
      # have the same value. This is not the case in my input data.
      nums = Set.new
      for n in @neighbors
        candidate = [star[0]+n[0],star[1]+n[1]]
        if map.key?(candidate)
          if map[candidate].match?(/\d/)
            num = boundary(map, candidate)
            nums.add(parse_number(map, num[0], num[1], star[1]+n[1]))
          end
        end
      end
      if nums.length == 2
        sum += nums.reduce(:*)
      end
    end
    sum
  end
end

