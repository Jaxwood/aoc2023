# frozen_string_literal: true

module HandType
  FIVE_OF_A_KIND = 1
  FOUR_OF_A_KIND = 2
  FULL_HOUSE = 3
  THREE_OF_A_KIND = 4
  TWO_PAIR = 5
  ONE_PAIR = 6
  HEIGH_CARD = 7
end

# Camel Hand
class CamelHand
  def initialize(raw, score)
    @cards = raw.chars
    @score = score.to_i
    @hand_type = determine_hand_type
    order = %w[A K Q J T 9 8 7 6 5 4 3 2]
    @rank = []
    @cards.each { |card| @rank << order.index(card) }
  end

  attr_reader :hand_type, :rank

  def score(rank)
    @score * rank
  end

  def to_s
    @cards.join('')
  end

  private

  def determine_hand_type
    type = @cards.tally.values.sort

    return HandType::FIVE_OF_A_KIND if type == [5]
    return HandType::FOUR_OF_A_KIND if type == [1, 4]
    return HandType::FULL_HOUSE if type == [2, 3]
    return HandType::THREE_OF_A_KIND if type == [1, 1, 3]
    return HandType::TWO_PAIR if type == [1, 2, 2]
    return HandType::ONE_PAIR if type == [1, 1, 1, 2]
    return HandType::HEIGH_CARD if type == [1, 1, 1, 1, 1]

    panic 'Unknown hand type'
  end
end

# Day07
class Day07
  def load(file)
    @lines = File.readlines(file)
  end

  def part1
    hands = []
    @lines.each do |line|
      parts = line.split(' ')
      hands << CamelHand.new(parts[0], parts[1])
    end

    hands.sort_by! { |hand| [hand.hand_type, hand.rank] }
    hands.reverse.each_with_index.reduce(0) { |total, (hand, index)| total + hand.score(index + 1) }
  end
end
