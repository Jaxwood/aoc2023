class Round
  attr_accessor :blue, :green, :red

  def initialize
    @blue = 0
    @green = 0
    @red = 0
  end

  def to_s
    "blue #{@blue} green #{@green} red #{@red}"
  end
end

class Game
  attr_accessor :id, :rounds

  def initialize
    @id = 0
    @rounds = []
  end

  def to_s
    "game #{@id} with rounds #{@rounds}"
  end
end

class Day02
  def load(file)
    @lines = File.readlines(file)
  end

  def parse(line)
    # get game
    segments = line.split(":")
    game = Game.new
    game.id = segments[0].split(" ")[1].to_i

    # get rounds
    games = segments[1].split(";")
    games.each do |g|
      colors = g.split(",")
      round = Round.new
      colors.each do |c|
        if c.include?("blue")
          round.blue = c.split(" ")[0].to_i
        elsif c.include?("green")
          round.green += c.split(" ")[0].to_i
        elsif c.include?("red")
          round.red += c.split(" ")[0].to_i
        end
      end
      game.rounds << round
    end
    game
  end

  def part1
    sum = 0
    games = []
    @lines.each do |line|
      games << parse(line)
    end
    games.each do |g|
      valid = true
      g.rounds.each do |r|
        if r.blue > 14
          valid = false
        elsif r.green > 13
          valid = false
        elsif r.red > 12
          valid = false
        end
      end
      if valid
        sum += g.id
      end
    end
    sum
  end

  def part2
    sum = 0
    games = []
    @lines.each do |line|
      games << parse(line)
    end
    games.each do |g|
      max_blue = 0
      max_green = 0
      max_red = 0
      g.rounds.each do |r|
        max_blue = [max_blue, r.blue].max
        max_green = [max_green, r.green].max
        max_red = [max_red, r.red].max
      end
      sum += max_blue * max_green * max_red
    end
    sum
  end
end
