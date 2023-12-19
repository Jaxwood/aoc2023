# frozen_string_literal: true

# Day19
class Day19
  def load(file)
    content = File.read(file)
    @rules = {
      'A' => [['A']],
      'R' => [['R']]
    }
    (rules, parts) = content.split("\n\n")
    rulelist = rules.split("\n")
    rulelist.each do |rule|
      (id, rule) = rule.split('{')
      lst = []
      rule.split(',').each do |r|
        rs = []
        if r =~ /\w+}/
          rs << r[..-2]
        else
          r.scan(/(\w+)([<>])(\d+):(\w+)/)[0].each do |n|
            rs << if n.include?('<') || n.include?('>')
                    n.to_sym
                  elsif n.scan(/\d+/).any?
                    n.to_i
                  else
                    n
                  end
          end
        end
        lst << rs
      end
      @rules[id] = lst
    end

    @parts = []
    parts.split("\n").each do |part|
      machine = {}
      part[1..-2].split(',').each do |c|
        (mach, value) = c.split('=')
        machine[mach.strip] = value.strip.to_i
      end
      @parts << machine
    end
  end

  def part1
    sum = 0
    @parts.each do |part|
      queue = @rules['in'].dup
      while queue.any?
        rule = queue.shift
        if rule.length == 1
          queue = @rules[rule.first].dup if rule.first != 'A' && rule.first != 'R'
          sum += part.values.sum if rule.first == 'A'
          queue = [] if rule.first == 'A' || rule.first == 'R'
        else
          (op, cond, val, to) = rule
          case cond
          when :>
            queue = @rules[to].dup if part[op] > val
          when :<
            queue = @rules[to].dup if part[op] < val
          else
            raise "unknown condition #{cond}"
          end
        end
      end
    end
    sum
  end
end
