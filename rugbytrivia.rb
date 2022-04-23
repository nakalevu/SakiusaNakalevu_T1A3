# Class for the rugby trivia app
class Trivia

    def initialize
# Letters for the user to select will be stored to an array instance variable used so it can be accessed from different methods in the class
        @letters = ("a".."z").to_a
        @question = questions.sample

        # Number of chances user has before losing the trivia game
        @lives = 5

        # Empty array to store correct guesses
        @right_guesses = []

        # Correct letters to be stored in this instance variable
        @word_teaser = ""

        # This code will run a loop over depending on the number of charachters in the answer
        @question.first.size.times do
            word_teaser += "_ "
        end
    end

# Trivia questions...answers followed by the questions
    def questions
        [
            ["Webb Ellis Cup", "What is the Rugby World Cup trophy called?"],
            ["New Zealand", "Which country won the first Rugby World Cup?"],
            ["Fiji", "Which country has won the rugby 7's gold medal in the Olympics twice?"],
            ["John Eales", "Name Australia's most successful captain?"],
            ["Crusaders", "Name the most successful super rugby team?"],
            ["England", "Name the country that won the 2003 Rugby World Cup?"],
            ["New Zealand", "Which country took first place in the inaugral HSBC worls 7's series?"],
            ["South Africa", "Which country won the Rugby World Cup in 2007 & 2019?"],
        ]
    end
    
    def print_teaser last_guess = nil
        word_teaser = ""

        # Update method to be called if last_guess method is not nil
        update_teaser unless last_guess.nil?
        puts word_teaser
    end

# Prompts user to select a letter
    def guess_letter
        if @lives > 0
            puts "Guess a letter!"

            # captures user input
            guess = gets.chomp

            # Removes letters that raen't part of the answer from the array
            correct_guess = @question.first.include? guess

            # Output to screen depending on letter selected by user
            if correct_guess
                puts "Correct letter selected!"

                @right_guesses << guess

                # Remove selected letters from letter array
                @letters.delete guess

                print_teaser guess
                guess_letter
            else

                # Reduces number of attempts by one
                @lives -= 1

                puts "Sorry...you have #{ @lives } attempts remaining. Please try again!"
                guess_letter
            end
        else
            puts "Better luck next time....Game over =("
        end

    end

# Begin quiz, ask user to select a letter
    def begin
        puts "Starting new quiz!" 

        # Displays question for the user to answer
        puts "Your question is: #{ @question.last }"
        print_teaser

        # Gives the user the number of letters/characters the answer has
        puts "Your answer has #{ @question.first.size } characters."

        guess_letter

    end


end

quiz = Trivia.new
quiz.begin           