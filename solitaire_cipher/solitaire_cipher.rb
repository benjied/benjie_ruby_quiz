require 'deck'

class SolitaireCipher

  def self.make_card_a_letter card_value
    if Deck::JOKERS.include? card_value
      letter = nil
    else
      card_value -= 26 if card_value > 26
      letter = (card_value + 64).chr
    end
  end
  
  def self.generate_a_non_nil_key_letter deck
    key_letter = nil
    while key_letter == nil
      deck.move('A', 1)
      deck.move('B', 2)
      deck.triple_cut('A', 'B')
      deck.count_cut
      key_letter = make_card_a_letter deck.output_card
    end
    key_letter
  end
  
  def self.generate_keystream length
    deck = Deck.new
    keystream = []
    length.times do
      keystream << generate_a_non_nil_key_letter(deck)
    end
    keystream.join
  end
  
  def self.convert_to_numbers(stream_of_letters)
    stream_of_letters.split(//).map do |letter|
      letter[0]-64
    end
  end
  
  def self.encrypt message
    message_as_numbers = convert_to_numbers(message.gsub(/\W/, '').upcase)
    keystream_as_numbers = convert_to_numbers(generate_keystream(message.length))
    
    encrypted_numbers = []
    message_as_numbers.each_index do |index|
      number = message_as_numbers[index] + keystream_as_numbers[index]
      number = number - 26 if number > 26
      encrypted_numbers << number
    end
    convert(encrypted_numbers)
  end
  
  def self.decrypt message
    message_as_numbers = convert_to_numbers(message.gsub(/\W/, '').upcase)
    keystream_as_numbers = convert_to_numbers(generate_keystream(message.length))
    
    decrypted_numbers = []
    message_as_numbers.each_index do |index|
      number = message_as_numbers[index] - keystream_as_numbers[index]
      number += 26 if number < 1
      decrypted_numbers << number
    end
    convert(decrypted_numbers)
  end
  
  def self.convert message_as_numbers
    message_as_letters = message_as_numbers.map do |number|
      (number + 64).chr
    end
    array_of_strings = []
    (message_as_letters.size/5).times do |offset|
      array_of_strings << message_as_letters[5*offset..5*offset+4].join
    end
    array_of_strings.join(' ')
  end
end
