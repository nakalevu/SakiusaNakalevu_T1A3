# frozen_string_literal: true

require 'colorize'
require 'rubocop'
require 'cspec'
# Class for the rugby trivia app
class RugbyTrivia
  
  def initialize
    @question = questions.sample

    # Number of chances user has before losing the trivia game
    @lives = 5

    # Correct letters to be stored in this instance variable
    @word_teaser = ''

    # This code will run a loop over depending on the number of charachters in the answer
    @question.first.size.times do
      @word_teaser += '_ '
    end
  end

  # Trivia questions...answers are followed by the questions
  def questions
    [
      ['WebbEllisCup', 'What is the Rugby World Cup trophy called?'],
      ['NewZealand', 'Which country won the first Rugby World Cup?'],
      ['Fiji', "Which country has won the rugby 7's gold medal in the Olympics twice?"],
      ['JohnEales', "Name Australia's most successful captain?"],
      ['Crusaders', 'Name the most successful super rugby team?'],
      ['England', 'Name the country that won the 2003 Rugby World Cup?'],
      ['NewZealand', "Which country took first place in the inaugral HSBC worls 7's series?"],
      ['SouthAfrica', 'Which country won the Rugby World Cup in 2007 & 2019?']
    ]
  end

  def print_teaser(last_guess = nil)
    # Update method to be called if last_guess method is not nil
    update_teaser(last_guess) unless last_guess.nil?
    puts @word_teaser
  end

  def update_teaser(last_guess)
    # Output an array of underscores
    new_teaser = @word_teaser.split

    new_teaser.each_with_index do |letter, index|
      # Correct letters will replace the underscores holding their place
      new_teaser[index] = last_guess if letter == '_' && @question.first[index] == last_guess
    end

    # Overriding instance variable with new value by joining array together as a string
    @word_teaser = new_teaser.join(' ')
  end

  # Prompts user to select a letter
  def guess_letter
    if @lives.positive?
      puts 'Guess a letter!'.colorize(:blue)

      # captures user input
      guess = gets.chomp

      # Removes letters that aren't part of the answer from the array
      correct_guess = @question.first.include? guess

      # Option to exit quiz
      if guess == 'exit'
        puts 'Thank you for playing.'.colorize(:blue)

      # Output to screen depending on letter selected by user
      elsif correct_guess
        puts 'Correct!'.colorize(:blue)

        print_teaser guess

        # Checks that the teaser word matches the answer and removes the space between characters, spilts teaser into arrays first then joined into a string.
        if @question.first == @word_teaser.split.join
          puts 'Round won...Congratulations!'.colorize(:blue)
        else
          guess_letter
        end
      else

        # Reduces number of attempts by one
        @lives -= 1

        puts "Sorry...you have #{@lives} attempts remaining. Please try again!".colorize(:red).on_blue.underline
        guess_letter
      end
    else
      puts 'Better luck next time....Game over =('.colorize(:red).on_blue.underline
    end
  end

  # Begin quiz, ask user to select a letter
  def begin
    puts 'Starting new quiz!'.colorize(:blue)
    puts 'Answers are case sensitive'.colorize(:blue)

    # Displays question for the user to answer
    puts "Your question is: #{@question.last}".colorize(:blue)
    puts "Type 'exit' to leave quiz".colorize(:blue)
    print_teaser

    # Gives the user the number of letters/characters the answer has
    puts "Your answer has #{@question.first.size} characters.".colorize(:blue)

    guess_letter
  end
end

quiz = RugbyTrivia.new
quiz.begin
