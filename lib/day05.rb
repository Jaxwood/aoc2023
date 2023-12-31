# frozen_string_literal: true

# Stores a rule
class Rule
  def initialize(from, to, offset)
    @range = to..(to + offset)
    @offset = from - to
  end

  attr_reader :range, :offset

  def overlapping(other)
    return unless other.begin <= @range.end && @range.begin <= other.end

    ([@range.begin, other.begin].max..[@range.end, other.end].min)
  end

  def within_range?(seed)
    @range.include?(seed)
  end

  def transform(seed)
    seed + @offset
  end

  def to_s
    "#{@range.begin}-#{@range.end} -> #{@offset}"
  end
end

# Stores agricultral data
class Almanac
  def initialize(rules)
    @rules = rules
  end

  attr_reader :rules

  def get_seed(seed)
    @rules.each do |rule|
      return rule.transform(seed) if rule.within_range?(seed)
    end
    seed
  end

  def get_seed_with_range(seed_ranges); end

  def to_s
    @rules.join("\n")
  end
end

class Day05
  def initialize
    @pipeline = []
    @seeds = []
  end

  def parse_section(file, section)
    source = []
    destination = []
    range = []
    line = file.readline
    if line.start_with? section
      line = file.readline
      until line.empty?
        input = line.split(' ').map(&:to_i)
        destination << input[0]
        source << input[1]
        range << input[2]

        break if file.eof?

        line = file.readline.chomp
      end
    end
    [destination, source, range]
  end

  def parse_rule(sections)
    sections[0].zip(sections[1], sections[2]).map do |rule|
      Rule.new(rule[0], rule[1], rule[2])
    end
  end

  def parse(filename)
    File.open(filename, 'r') do |file|
      line = file.readline
      @seeds = line.split(':')[1].split(' ').map(&:to_i) if line.start_with? 'seeds'
      file.readline # skip blank line

      sections = parse_section(file, 'seed-to-soil map')
      seed = Almanac.new(parse_rule(sections))
      sections = parse_section(file, 'soil-to-fertilizer map')
      soil = Almanac.new(parse_rule(sections))
      sections = parse_section(file, 'fertilizer-to-water map')
      fertilizer = Almanac.new(parse_rule(sections))
      sections = parse_section(file, 'water-to-light map')
      water = Almanac.new(parse_rule(sections))
      sections = parse_section(file, 'light-to-temperature map')
      light = Almanac.new(parse_rule(sections))
      sections = parse_section(file, 'temperature-to-humidity map')
      temperature = Almanac.new(parse_rule(sections))
      sections = parse_section(file, 'humidity-to-location map')
      humidity = Almanac.new(parse_rule(sections))
      @pipeline = [seed, soil, fertilizer, water, light, temperature, humidity]
    end
  end

  def part1(filename)
    parse(filename)
    locations = []
    @seeds.each do |seed|
      locations << @pipeline.reduce(seed) { |acc, almanac| almanac.get_seed(acc) }
    end
    locations.min
  end

  def part2(filename)
    parse(filename)
    seeds = @seeds.each_slice(2).map { |seed| (seed[0]..seed[0] + seed[1]) }

    @pipeline.reduce(seeds) do |acc, almanac|
      acc.flat_map do |seed|
        locations = []
        curr = seed.begin

        almanac.rules
               .sort_by { |rule| rule.range.begin }
               .each do |rule|
                 new_range = rule.overlapping(seed)
                 next unless new_range

                 locations << ((new_range.begin + rule.offset)..(new_range.end + rule.offset))
                 curr = new_range.end + 1
               end

        locations << (curr..seed.end) if curr < seed.end

        locations
      end
    end
      .map(&:begin).min
  end
end
