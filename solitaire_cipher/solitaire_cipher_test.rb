require 'test/unit'
require 'solitaire_cipher'
require 'deck'

class SolitaireCipherTest < Test::Unit::TestCase

  def test_package_into_array_of_letters
    assert_equal ['C','O','D','E','I','N','R','U','B','Y','L','I','V','E','L','O','N','G','E','R'], SolitaireCipher.package_into_array_of_letters("Code in Ruby, live longer!")
  end
  
  def test_convert_array_of_letters_to_numbers
    assert_equal [3,15,4,5,9,14,18,21,2,25,12,9,22,5,12,15,14,7,5,18], 
                      SolitaireCipher.convert_array_of_letters_to_numbers(['C','O','D','E','I','N','R','U','B','Y','L','I','V','E','L','O','N','G','E','R'])
  end
  
  def test_convert_to_letters
    assert_equal ['C','O','D','E','I','N','R','U','B','Y','L','I','V','E','L','O','N','G','E','R'], SolitaireCipher.convert_to_letters([3,15,4,5,9,14,18,21,2,25,12,9,22,5,12,15,14,7,5,18])
  end

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
  
  def test_generate_keystream
    assert_equal 'DWJXHYRFDGTMSHPUURXJ', SolitaireCipher.generate_keystream(20)
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
############### Everything below here needs to be re-written ##############
# Decide_to_encrypt_or_decrypt should be called "generate_output_for"
# Most of encrypt and decrypt should be combined into one 'convert' , which calls "encrpyt or decrypt" which calls encrypt or decrpyt which are small
# There is also the problem about rounding down the length of the message to an even 5... need to pad with X's
    
  def test_solitaire_cipher_encryption
    assert_equal 'GLNCQ MJAFF FVOMB JIYCB', SolitaireCipher.encrypt("Code in Ruby, live longer!")
  end
  
  def test_solitaire_cipher_decryption
    assert_equal "CODEI NRUBY LIVEL ONGER", SolitaireCipher.decrypt('GLNCQ MJAFF FVOMB JIYCB')
  end
  
  def test_decide_to_encrypt_or_decrypt_should_encrypt
    input_message = "Code in Ruby, live longer!"
    expected_output = "\n" + 'Encrypted message = ' + 'GLNCQ MJAFF FVOMB JIYCB' + "\n\n"
    
    assert_equal expected_output, SolitaireCipher.decide_to_encrypt_or_decrypt(input_message)
    
  end
  
  def test_decide_to_encrypt_or_decrypt_should_decrypt
    input_message = "GLNCQ MJAFF FVOMB JIYCB"
    expected_output = "\n" + 'Decrypted message = ' + 'CODEI NRUBY LIVEL ONGER' + "\n\n"
    
    assert_equal expected_output, SolitaireCipher.decide_to_encrypt_or_decrypt(input_message)
    
  end
  
  def test_decide_to_encrypt_or_decrypt_will_encrypt_CODEINRUBYLIVELONGER
    input_message = "CODEINRUBYLIVELONGER"
    expected_output = "\n" + 'Encrypted message = ' + 'GLNCQ MJAFF FVOMB JIYCB' + "\n\n"
    
    assert_equal expected_output, SolitaireCipher.decide_to_encrypt_or_decrypt(input_message)
    
  end  
  
end

