class Deck
  attr_reader :cards
  JOKERS = ['A', 'B']
  
  def initialize
    @cards = []
    (1..52).each{|i| @cards << i} 
    @cards<<'A'
    @cards<<'B'
  end
  
  def move card, places
    card_starts_at = @cards.index(card)
    @cards.delete_at(card_starts_at)
    if card_starts_at + places < 54
      @cards.insert(card_starts_at+places, card)
    else
      @cards.insert((card_starts_at+places-53), card)
    end
  end
  
  def triple_cut cut_one, cut_two
    first_cut = @cards.index(cut_one)
    second_cut = @cards.index(cut_two)
    
    if first_cut > second_cut
      placeholder = first_cut
      first_cut = second_cut
      second_cut = placeholder
    end
    
    end_of_deck = @cards.slice!((second_cut+1)..53)
    start_of_deck = @cards.slice!(0...first_cut)
    
    @cards = end_of_deck + @cards + start_of_deck    
    
  end
  
  def count_cut
    if JOKERS.include?(@cards.last)
      count = 53
    else
      count = @cards.last
    end    
    cut = @cards.slice!(0..(count-1))
    @cards.insert(-2, cut)
    @cards = @cards.flatten
  end
  
  def output_card
    if JOKERS.include?(@cards.first)
      count = 53
    else
      count = @cards.first
    end          
    
    output_number = @cards[count]
    
  end
  
end
