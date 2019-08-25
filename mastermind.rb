module CheckColorMethods

    def color_check(guesses)
        j = 0

        @problem_colors.secret_colors.each do |color|
            i = 0
            guesses.each do |guess|
                if color == guess
                    guesses[i] = "match" 
                    next
                end
                i+=1
            end
        end

        guesses.each do |elm|
            if elm == "match"
                j+=1
                end
        end

        return j
    end

    def color_place_check(guesses)
        right_places = 0
        i = 0
    
        guesses.each do |guess|
            right_places+=1 if guess == @problem_colors.secret_colors[i]
            i+=1
        end
       
        return right_places
    end

end

class ProblemColors
    attr_reader :secret_colors

    @@colors = ["red", "orange", "yellow", "green", "blue", "voilet", "white", "black"]

    def initialize(color1 = nil, color2 = nil, color3 = nil, color4 = nil)
        @color1 = color1 ? color1 : @@colors[rand(@@colors.length)]
        @color2 = color2 ? color2 : @@colors[rand(@@colors.length)]
        @color3 = color3 ? color3 : @@colors[rand(@@colors.length)]
        @color4 = color4 ? color4 : @@colors[rand(@@colors.length)]
        @secret_colors = [@color1, @color2, @color3, @color4]
    end

    def self.colors
        @@colors
    end
end

class PlayerPlay
    include CheckColorMethods

    def initialize
        @problem_colors = ProblemColors.new
        play
    end

    def play
        puts "You have to guess the Secret Colors in 12 guesses->"
        puts "Choose from the following:"
        puts ProblemColors.colors
        
        correct_colors = 0
        i = 0

        while correct_colors != 4 && i<=12 
            puts "Guesses remaining: #{12-i}"
            puts "Enter your four guesses separated by ',':"
            guess = gets.chomp
            guesses = guess.downcase.split(",")

            correct_places = color_place_check(guesses)
            correct_colors = color_check(guesses)
            
            puts "You guess #{correct_colors} colors correct, in which #{correct_places} are in right order."

            i+=1
        end

        puts "Hurray! You won..." if correct_colors == 4
        puts "Hard Luck! correct color sequence is : #{@problem_colors.secret_colors.join(",")}"
    end

    

end

class ComputerPlay
    include CheckColorMethods

    def initialize(color_sequence)
        @problem_colors = ProblemColors.new(color_sequence[0],color_sequence[1],color_sequence[2],color_sequence[3] )
        play
    end

    def play
        guesses = guesses = guess_colors(0,1,2,3)
        
        correct_colors = color_check(guesses)

        if correct_colors >= 1
            guesses = guesses = guess_colors(0,1,2,3)
        else 
            guesses = guess_colors(4,5,6,7)
        end
        
        while correct_colors != 4
            
    end

    def guess_colors(a,b,c,d)
        guess1 = ProblemColors.colors[a]
        guess2 = ProblemColors.colors[b]
        guess3 = ProblemColors.colors[c]
        guess4 = ProblemColors.colors[d]

        guesses = [guess1,guess2, guess3, guess4]

        return guesses
    end

end

def game 
    puts "Welcome to the MASTERMIND."
    puts "Choose if you want to be the Player or Playee..."
    puts "Enter 1 for Player and 2 for Playee :)"
    choice = gets.chomp

    game = PlayerPlay.new if choice.to_i == 1
    
    if (choice.to_i == 2)
        puts "Enter 4 color Secret color code separated by ','..."
        puts "Choose from the following:"
        puts ProblemColors.colors

        color_sequence = gets.chomp
        color_sequence = color_sequence.downcase.split(",")

        game = ComputerPlay.new(color_sequence)
    end
end

game()
