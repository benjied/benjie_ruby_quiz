require 'test/unit'
require 'solitaire_cipher'
require 'deck'

class SolitaireCipherTest < Test::Unit::TestCase

  def test_step_one_of_encryption_package
    assert_equal 'CODEINRUBYLIVELONGER', SolitaireCipher.package("Code in Ruby, live longer!")
  end
  
  def test_step_three_of_encryption_make_numbers
    assert_equal [3,15,4,5,9,14,18,21,2,25,12,9,22,5,12,15,14,7,5,18], SolitaireCipher.convert_to_numbers('CODEINRUBYLIVELONGER')
  end
  
  def test_convert_to_letters
    assert_equal ['C','O','D','E','I','N','R','U','B','Y','L','I','V','E','L','O','N','G','E','R'], SolitaireCipher.convert_to_letters([3,15,4,5,9,14,18,21,2,25,12,9,22,5,12,15,14,7,5,18])
  end
  
  def test_a_new_clean_deck
    assert_equal [1,2,3,4,5,6,7,8,9,10,
                        11,12,13,14,15,16,17,18,19,
                        20,21,22,23,24,25,26,27,28,29,30,
                        31,32,33,34,35,36,37,38,39,
                        40,41,42,43,44,45,46,47,48,49,
                        50,51,52,'A','B'], 
                        Deck.make_deck
  end
                      
  def test_move_joker_A_down_one_card
    @deck = Deck.make_deck
    assert_equal [1,2,3,4,5,6,7,8,9,10,
                        11,12,13,14,15,16,17,18,19,
                        20,21,22,23,24,25,26,27,28,29,30,
                        31,32,33,34,35,36,37,38,39,
                        40,41,42,43,44,45,46,47,48,49,
                        50,51,52,'B','A'],
                        Deck.move_joker_A_down_one
  end
  
  def test_move_joker_B_down_two_cards
    @deck = Deck.make_deck
    @deck = Deck.move_joker_A_down_one

    assert_equal [1,'B',2,3,4,5,6,7,8,9,10,
                        11,12,13,14,15,16,17,18,19,
                        20,21,22,23,24,25,26,27,28,29,30,
                        31,32,33,34,35,36,37,38,39,
                        40,41,42,43,44,45,46,47,48,49,
                        50,51,52,'A'],
                        Deck.move_joker_B_down_two
  end


  def test_triple_cut
    @deck = Deck.make_deck
    @deck = Deck.move_joker_A_down_one
    @deck = Deck.move_joker_B_down_two
    assert_equal ['B',2,3,4,5,6,7,8,9,10,
                        11,12,13,14,15,16,17,18,19,
                        20,21,22,23,24,25,26,27,28,29,30,
                        31,32,33,34,35,36,37,38,39,
                        40,41,42,43,44,45,46,47,48,49,
                        50,51,52,'A',1],
                        Deck.triple_cut
  end
  
  def test_count_cut
    @deck = Deck.make_deck
    @deck = Deck.move_joker_A_down_one
    @deck = Deck.move_joker_B_down_two
    @deck = Deck.triple_cut
    
    assert_equal [2,3,4,5,6,7,8,9,10,
                        11,12,13,14,15,16,17,18,19,
                        20,21,22,23,24,25,26,27,28,29,30,
                        31,32,33,34,35,36,37,38,39,
                        40,41,42,43,44,45,46,47,48,49,
                        50,51,52,'A','B',1],
                        Deck.count_cut
  end                        

  def test_output_letter
    @deck = Deck.make_deck
    @deck = Deck.move_joker_A_down_one
    @deck = Deck.move_joker_B_down_two
    @deck = Deck.triple_cut
    @deck = Deck.count_cut
    assert_equal 'D', Deck.output_letter
  end
  
  def test_generate_keystream(length)
    @deck = Deck.make_deck
    @deck = Deck.move_joker_A_down_one
    @deck = Deck.move_joker_B_down_two
    @deck = Deck.triple_cut
    @deck = Deck.count_cut
    assert_equal 'DWJXHYRFDGTMSHPUURXJ', Deck.generate_keystream(25)
  end
    


  def test_solitaire_cipher_encryption
    assert_equal 'GLNCQ MJAFF FVOMB JIYCB', SolitaireCipher.encrypt("Code in Ruby, live longer!")
  end
  
end

