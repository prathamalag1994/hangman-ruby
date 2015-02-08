class HangpersonGame

	attr_accessor :word
	attr_accessor :guesses
	attr_accessor :wrong_guesses
	attr_accessor :guess
  attr_accessor :word_with_guesses
  attr_accessor :mess


  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def initialize(word)
  	@word = word.downcase
  	@guesses = ''
  	@wrong_guesses = ''
  	@guess = ''
    @word_with_guesses = ''
    @mess = ''
    x = word.length
    while x > 0  do
      @word_with_guesses = @word_with_guesses + "-"
      x = x - 1
    end
  end

  def guess(letter)
  	if letter == nil
      raise ArgumentError, 'Invalid guess.'
  	end
  	if letter == ''
      raise ArgumentError, 'Invalid guess.'
  	end
  	if not letter.match(/^[[:alpha:]]$/)
      raise ArgumentError, 'Invalid guess.'
  	end
    @guess = letter.to_s[0].downcase
  	if @guesses.include? @guess or @wrong_guesses.include? @guess
      @mess = "b"
      return false
    else
    	if @word.include? @guess
          x = 0;
          @word.each_char { |d|
          if d == @guess
            word_with_guesses[x] = d
          end
          x = x + 1
          }
      		@guesses = @guesses + @guess
      	else
      		@wrong_guesses = @wrong_guesses + @guess
      	end
    end
  end 

  def check_win_or_lose
    
    if not @word_with_guesses.include? "-"
      return :win
    elsif wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end

end
