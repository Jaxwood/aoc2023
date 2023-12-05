# frozen_string_literal: true

# Stores agricultral data
class Almanac
  def initialize(destinations, sources, ranges)
    @sources = sources
    @destinations = destinations
    @ranges = ranges
  end

  def get_seed(seed)
    result = seed
    @sources.each_with_index do |source, index|
      if source + @ranges[index] > seed && source <= seed
        offset = seed - source
        result = @destinations[index] + offset
      end
    end
    result
  end

  def to_s
    "Almanac #{@destinations} #{@sources} #{@ranges}"
  end
end

class Day05
  def initialize
    @seed = nil
    @soil = nil
    @fertilizer = nil
    @water = nil
    @light = nil
    @temperature = nil
    @humidity = nil
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

  def parse(filename)
    File.open(filename, 'r') do |file|
      line = file.readline
      @seeds = line.split(':')[1].split(' ').map(&:to_i) if line.start_with? 'seeds'
      file.readline # skip blank line

      sections = parse_section(file, 'seed-to-soil map')
      @seed = Almanac.new(sections[0], sections[1], sections[2])
      sections = parse_section(file, 'soil-to-fertilizer map')
      @soil = Almanac.new(sections[0], sections[1], sections[2])
      sections = parse_section(file, 'fertilizer-to-water map')
      @fertilizer = Almanac.new(sections[0], sections[1], sections[2])
      sections = parse_section(file, 'water-to-light map')
      @water = Almanac.new(sections[0], sections[1], sections[2])
      sections = parse_section(file, 'light-to-temperature map')
      @light = Almanac.new(sections[0], sections[1], sections[2])
      sections = parse_section(file, 'temperature-to-humidity map')
      @temperature = Almanac.new(sections[0], sections[1], sections[2])
      sections = parse_section(file, 'humidity-to-location map')
      @humidity = Almanac.new(sections[0], sections[1], sections[2])
    end
  end

  def part1(filename)
    parse(filename)
    locations = []

    @seeds.each do |seed|
      soil = @seed.get_seed(seed)
      fertilizer = @soil.get_seed(soil)
      water = @fertilizer.get_seed(fertilizer)
      light = @water.get_seed(water)
      temperature = @light.get_seed(light)
      humidity = @temperature.get_seed(temperature)
      locations << @humidity.get_seed(humidity)
    end

    locations.min
  end
end
