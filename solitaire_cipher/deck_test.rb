require 'test/unit'
require 'deck'

class DeckTest < Test::Unit::TestCase
  def test_a_new_deck
    deck = Deck.new
  
    expected = [*1..52] + ['A', 'B']
    assert_equal expected, deck.cards
  end

  def test_move_a_card_down_one
    deck = Deck.new
    deck.move 'A', 1
  
    expected = [*1..52] + ['B' , 'A']
    assert_equal expected, deck.cards
  end
  
  def test_move_a_card_past_the_end
    deck = Deck.new
    deck.move 'A', 2
    
    expected = [1, 'A'] + [*2..52] + ['B']
    assert_equal expected, deck.cards
  end
  
  def test_triple_cutting_the_deck
    deck = Deck.new
    deck.triple_cut 17, 34
    
    expected = [*35..52] + ["A", "B"] + [*17..34] + [*1..16]
    assert_equal expected, deck.cards
  end
  
  def test_triple_cutting_with_cut_cards_out_of_order
    deck = Deck.new
    deck.triple_cut 34, 17
    
    expected = [*35..52] + ["A", "B"] + [*17..34] + [*1..16]
    assert_equal expected, deck.cards
  end
  
  def test_count_cut
    deck = Deck.new
    deck.count_cut
    
    expected = [*1..52] + ['A' , 'B']
    assert_equal expected, deck.cards
    
  end
  
  def test_count_cut_works_for_cards_other_than_jokers_at_bottom
    deck = Deck.new
    deck.move 1, 53
    deck.count_cut
    
    expected = [*3..52] + ['A','B'] + [2] + [1]
    assert_equal expected, deck.cards
    
  end  
  
  def test_final_deck
    deck = Deck.new
    
    deck.move 'A', 1
    deck.move 'B', 2
    deck.triple_cut 'B', 'A'
    deck.count_cut
    
    expected = [*2..52] + ['A', 'B', 1]
    assert_equal expected, deck.cards
  end
  
end








