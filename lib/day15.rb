# frozen_string_literal: true

# Day15
class Day15
  def load(file)
    @sequence = File.read(file).split(',').map(&:strip)
  end

  def box_no(candidate)
    val = 0
    candidate.chars.each do |c|
      val = ((val + c.ord) * 17) % 256
    end
    val
  end

  def part1
    results = []
    @sequence.each do |s|
      results.push(box_no(s))
    end
    results.sum
  end

  def part2
    boxes = {}
    label_map = {}
    @sequence.each do |s|
      parts = s.split(/[=-]/)
      label = parts[0]
      label_map[label] = parts[1].to_i if s.include?('=')
      no = box_no(label).to_i
      box = boxes.fetch(no, [])

      if s.include?('=')
        box.push(label) unless box.include?(label)
      elsif s.include?('-')
        box.delete(label)
      end

      boxes[no] = box
    end

    total = 0
    boxes.each do |k, v|
      v.each_with_index do |l, i|
        total += label_map[l] * (i + 1) * (k + 1)
      end
    end
    total
  end
end
