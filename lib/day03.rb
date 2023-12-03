class Day03
  def load(file)
    @lines = File.readlines(file)
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
    if candidate != "." and !candidate.match?(/\d/)
      return true
    end
    false
  end

  def is_valid?(map, from, to, y)
    neighbors = [[1,0], [-1,0], [0,1], [0,-1], [1,1], [-1,-1], [1,-1], [-1,1]]

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
      for n in neighbors
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
              nums << parse_number(map, from, x, y)
            end
            from = nil
          end
        end
      end
    end
    nums.sum
  end
end
