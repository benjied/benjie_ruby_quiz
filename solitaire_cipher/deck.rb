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
    if JOKERS.include? @cards.last
      count = 53
    else
      count = @cards.last
    end    
    cut = @cards.slice!(0..(count-1))
    @cards.insert(-2, cut)
    @cards = @cards.flatten
  end
  
  def output_card
    if JOKERS.include? @cards.first
      count = 53
    else
      count = @cards.first
    end          
    
    output_number = @cards[count]
    
  end
  
  
 ##################################################################################### 

  def self.output_letter()
    number_to_count = @deck[0]
    if number_to_count == ('A' or 'B')
      number_to_count = 53
    end
    output_number = @deck[number_to_count]
    if output_number == ('A' or 'B')
      output_letter = nil
    else
      output_number -= 26 if output_number > 26
      output_letter = (output_number + 64).chr
    end
  end

  def self.generate_keystream(length)
    make_deck
    keystream = []
    length.times do
      move_joker_A_down_one
      move_joker_B_down_two
      triple_cut
      count_cut
      keystream <<output_letter
    end
    puts keystream
  end
end
