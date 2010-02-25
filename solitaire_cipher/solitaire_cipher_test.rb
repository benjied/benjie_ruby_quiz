
# There is the problem about rounding down the length of the message to an even 5... need to pad with X's

require 'test/unit'
require 'solitaire_cipher'

class SolitaireCipherTest < Test::Unit::TestCase

  def test_make_card_a_letter_from_deck_output_card
    deck = Deck.new
    card_value = deck.output_card

    assert_equal 'B', SolitaireCipher.make_card_a_letter(card_value)
  end
  
  def test_make_card_a_letter_if_bigger_than_26
    deck = Deck.new
    deck.move(50, 5)
    deck.move(1, 1)
    card_value = deck.output_card

    assert_equal 'Y', SolitaireCipher.make_card_a_letter(card_value)
  end
  
  def test_make_card_a_letter_returns_nil_for_JOKERS
    deck = Deck.new
    deck.move(52, 3)
    deck.move(1, 1)
    card_value = deck.output_card

    assert_equal nil, SolitaireCipher.make_card_a_letter(card_value)
  end
  
  def test_generate_a_non_nil_key_letter
    expected_deck = Deck.new
    expected_deck.move(52, 3)
    expected_deck.move(1, 1)
    
    test_deck = Deck.new
    test_deck.move(52, 3)
    test_deck.move(1, 1)

    expected_deck.move('A', 1)
    expected_deck.move('B', 2)
    expected_deck.triple_cut('A', 'B')
    expected_deck.count_cut

    card_value = expected_deck.output_card
    output_letter = SolitaireCipher.make_card_a_letter(card_value)

    assert_equal 'Z', SolitaireCipher.generate_a_non_nil_key_letter(test_deck)
  end
  
  def test_encrypt_message
    message = 'Code in Ruby, live longer!'
    encrypted_message = 'GLNCQ MJAFF FVOMB JIYCB'
    
    assert_equal encrypted_message, SolitaireCipher.encrypt(message)
  end
  
  def test_decrypt_message
    coded_message = 'GLNCQ MJAFF FVOMB JIYCB'
    plaintext_message = 'CODEI NRUBY LIVEL ONGER'
    
    assert_equal plaintext_message, SolitaireCipher.decrypt(coded_message)    
  end
  
  # def test_encrypt
  #   numbered_message = [3,15,4,5,9,14,18,21,2,25,12,9,22,5,12,15,14,7,5,18]
  #   numbered_keystream = [4,23,10,24,8,25,18,6,4,7,20,13,19,8,16,21,21,18,24,10]
  #   numbered_code = [7,12,14,3,17,13,10,1,6,6,6,22,15,13,2,10,9,25,3,2]
  #   
  #   assert_equal numbered_code, SolitaireCipher.encrypt(numbered_message, numbered_keystream)
  # end
  # 
  # def test_decrypt
  #   numbered_code = [7,12,14,3,17,13,10,1,6,6,6,22,15,13,2,10,9,25,3,2]
  #   numbered_keystream = [4,23,10,24,8,25,18,6,4,7,20,13,19,8,16,21,21,18,24,10]
  #   numbered_message = [3,15,4,5,9,14,18,21,2,25,12,9,22,5,12,15,14,7,5,18]
  #   
  #   assert_equal numbered_message, SolitaireCipher.decrypt(numbered_code, numbered_keystream)
  # end

end

