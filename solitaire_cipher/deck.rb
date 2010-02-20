
class Deck
  def self.make_deck()
    @deck = []
    (1..52).each{|i| @deck << i} 
    @deck<<'A'
    @deck<<'B'
  end
  
  def self.move_joker_A_down_one()
    a_starts_at = @deck.index("A")
    @deck.delete_at(a_starts_at)
    if a_starts_at < 53
      @deck.insert(a_starts_at+1, "A")
    else
      @deck.insert(1, "A")
    end
    @deck
  end

  def self.move_joker_B_down_two()
    b_starts_at = @deck.index("B")
    @deck.delete_at(b_starts_at)
    if b_starts_at < 52
      @deck.insert(b_starts_at+2, "B")
    elsif b_starts_at == 52
      @deck.insert(1, "B")
    else
      @deck.insert(2, "B")
    end
    @deck
  end
  
  def self.triple_cut()
    a_index = @deck.index("A")
    b_index = @deck.index("B")
    
    if a_index < b_index
      first_cut = a_index
      second_cut = b_index
    else
      first_cut = b_index
      second_cut = a_index
    end
    
    end_of_deck = @deck.slice!((second_cut+1)..53)
    start_of_deck = @deck.slice!(0...first_cut)
    
    @deck = end_of_deck + @deck + start_of_deck
    
  end

  def self.count_cut()

    if @deck[53] == ("A" or "B")
      count = 53
    else
      count = @deck[53]
    end    
    
    cut = @deck.slice!(0...count)
    @deck.insert(-2, cut).flatten
    
  end

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
  end
end
