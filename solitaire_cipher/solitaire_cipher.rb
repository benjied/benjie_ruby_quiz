# mkdir ruby_quiz
# cd ruby_quiz
# git init
# touch README
# git add README
# git commit -m 'first commit'
# git remote add origin git@github.com:benjied/ruby_quiz.git
# git push origin master
class SolitaireCipher
  input_message = ARGV[0]
  JOKERS = ['A', 'B']

  if input_message =~ %{^[A-Z][A-Z][A-Z][A-Z][A-Z]( [A-Z][A-Z][A-Z][A-Z][A-Z])*}
#    input_message.decrypt
  else
#    encrypt(input_message)    
  end

  def self.package_into_array_of_letters message
    stripped_message = message.gsub(/\W/, '').upcase.split(//)
  end
  
  def self.convert_array_of_letters_to_numbers(array_of_letters)
    array_in_numbers = []
    array_of_letters.each { |character| array_in_numbers <<  (character[0]-64)  }
    array_in_numbers
  end
  
  def self.convert_to_letters numbered_code
    message_in_letters = []
    numbered_code.each { |number| message_in_letters << (number + 64).chr }
    message_in_letters
  end
  
  def self.make_card_a_letter card_value
    if JOKERS.include? card_value
      letter = nil
    else
      card_value -= 26 if card_value > 26
      letter = (card_value + 64).chr
    end
  end
  
  def self.generate_a_non_nil_key_letter(deck)
    key_letter = nil
    while key_letter == nil
      deck.move('A', 1)
      deck.move('B', 2)
      deck.triple_cut ('A', 'B')
      deck.count_cut
      key_letter = make_card_a_letter(deck.output_card)
    end
    key_letter
  end
  
  def self.generate_keystream length
    deck = Deck.new
    keystream = []
    length.times do
      keystream <<generate_a_non_nil_key_letter(deck)
    end
    keystream
  end
  
  
  ##########################33
  
  def self.encrypt(message)
    packaged_message = package_into_array_of_letters(message)
    numbered_message = convert_array_of_letters_to_numbers(packaged_message)
    keystream = Deck.generate_keystream(numbered_message.length) # this line contains the problem
    puts keystream
    numbered_keystream = convert_array_of_letters_to_numbers(keystream)
    numbered_code = []
    numbered_message.each_index do |index|
      number = numbered_message[index] + numbered_keystream[index]
      number = number - 26 if numberr > 26
      numbered_code << number
    end
    coded_message = convert_to_letters(numbered_code)
    
    number_of_groups = packaged_message.length/5
    array_of_strings = []
    number_of_groups.times do |offset|
      array_of_strings << coded_message[5*offset..5*offset+4]
    end
    coded_message = array_of_strings.join(' ')
    
    puts coded_message
    
  end

  
end

