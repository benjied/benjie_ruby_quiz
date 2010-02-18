require 'test/unit'
require 'solitaire_cipher'

class SolitaireCipherTest < Test::Unit::TestCase

  def test_step_one_of_encryption
    assert_equal 'CODEI NRUBY LIVEL ONGER', SolitaireCipher.encrypt("Code in Ruby, live longer!")
  end
  
  # def test_solitaire_cipher_encryption
  #   assert_equal 'GLNCQ MJAFF FVOMB JIYCB', SolitaireCipher.encrypt("Code in Ruby, live longer!")
  # end
end