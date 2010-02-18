# mkdir ruby_quiz
# cd ruby_quiz
# git init
# touch README
# git add README
# git commit -m 'first commit'
# git remote add origin git@github.com:benjied/ruby_quiz.git
# git push origin master
class SolitaireCipher

  def self.encrypt(message)
    stripped_message = message.gsub(/\W/, '').upcase
    length = stripped_message.length
    number_of_groups = length/5
    array_of_strings = []
    number_of_groups.times do |offset|
      array_of_strings << stripped_message[5*offset..5*offset+4]
    end
    array_of_strings.join(' ')
  end
  
end
