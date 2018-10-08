# Require in Ruby gems
require 'tty-font'
require 'tty-spinner'
require 'net/http'
require 'json'

# General module container for all methods
module Methods

    # Main menu for users to select an action
    def self.main_menu(font, spinner)
        puts '''
        ============================================================
                               WELCOME TO
    
        '''
        puts font.write("              myMDb")
        puts '''
        ============================================================
        '''
    spinner.auto_spin
    sleep 2
    spinner.stop
    
        puts """
        Welcome to myMDb!
        What would you like to do today?
        1. Search Movies
        2. View my myMDb list
        3. I'm feeling...
        4. Exit
       
        """
    end
    
    # Search and create a new movie hash
    def self.search_for_movie(array, api_key)
        puts "What movie would you like to add or search for?"
        movie_search = gets.strip.downcase.gsub(' ','+')
        url = "http://www.omdbapi.com/?t=#{movie_search}&apikey=#{api_key}"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        movie_result = JSON.parse(response)
        movie_title = movie_result["Title"]
        movie_year = movie_result["Year"]
        movie_director = movie_result["Director"]
        movie_genre = movie_result["Genre"]
        movie_plot = movie_result["Plot"]
        puts """
        We've found the below.

        Title: #{movie_title}
        Director: #{movie_director}
        Released: #{movie_year}
        Genre: #{movie_genre}
        Plot: #{movie_plot}
        """
    
        puts """
    
        Is this what you're looking for?
        1. Yes - add to library.
        2. No - search title again.
        3. Take me back to the main menu

        """
        search_again = gets.chomp.to_i
        if search_again == 1
        array << movie_result
            puts "You have successfully added this movie to your myMDb list!"
        elsif search_again == 2
            puts "Let's do that again!"
            search_for_movie(array, api_key)
        end
    
    end
    
    # Display list of movies that you have saved in a single session
    def self.display_movie_list(arr)
        puts "This is your list of movies: "
        arr.each_with_index do |movie, index| 
            puts "#{index + 1}.#{movie['Title']}"
            puts "#{movie['Genre']}"
            puts "#{movie['Plot']}"
            puts "-" * 100
        end
        viewing = true
        while viewing == true
            sleep 1
            puts """
            Would you like to return to the main menu?
            1. Yes
            2. No
            """
            choice = gets.chomp.to_i
            if choice == 1
                break
            end
        end
    end
    
    # Mood menu to select your current mood
    def self.mood_choice(joyful, melancholy, nostalgic, futuristic, strange, netflix, thriller)
        puts """
        Let's pick a random movie based on mood!

        I'm feeling...
        1. Joyful (Comedy)
        2. Melancholy (Drama)
        3. Nostalgic (Classics)
        4. Futuristic (Sci-Fi)
        5. Strange (Arthouse)
        6. Netflix and Chill (Romantic)
        7. Like an Adrenaline Rush (Thriller)

        """
        selection = gets.chomp.to_i
    
        if selection == 1
            return joyful
        elsif selection == 2
            return melancholy
        elsif selection == 3
            return nostalgic
        elsif selection == 4
            return futuristic
        elsif selection == 5
            return strange
        elsif selection == 6
            return netflix
        elsif selection == 7
            return thriller
        else
            puts "Sorry I'm only a computer and I don't understand that emotion."
        end
    
    end
    
    # Finds a random movie for you from mood array based on your previous mood choice
    def self.mood_movie_search(mood_array, my_movies, api_key)
        if mood_array[0] == "Bruce Almighty"
            mood = "joyful"
        elsif mood_array[0] == "The Pianist"
            mood = "melancholy"
        elsif mood_array[0] == "East of Eden"
            mood = "nostalgic"
        elsif mood_array[0] == "Blade Runner"
            mood = "futuristic"
        elsif mood_array[0] == "Melancholia"
            mood = "strange"
        elsif mood_array[0] == "The Notebook"
            mood = "romantic"
        elsif mood_array[0] == "Minority Report"
            mood = "restless"
        end

        movie_search = mood_array[rand(mood_array.length)]
        url = "http://www.omdbapi.com/?t=#{movie_search}&apikey=#{api_key}"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        movie_result = JSON.parse(response)
        movie_title = movie_result["Title"]
        movie_year = movie_result["Year"]
        movie_director = movie_result["Director"]
        movie_genre = movie_result["Genre"]
        movie_plot = movie_result["Plot"]

        puts """
        I see you're feeling....#{mood}.. how about the below?
        
        Title: #{movie_title}
        Director: #{movie_director}
        Released: #{movie_year}
        Genre: #{movie_genre}
    
        #{movie_plot}
        """
    
        puts """
    
        Is this what you're looking for?
        1. Yes - add to library.
        2. No - search title again.
        3. Back to main menu

        """

        search_again = gets.chomp.to_i
        if search_again == 1
        my_movies << movie_result
            puts "You have successfully added this movie to your myMDb list!"
        elsif search_again == 2
            puts "Let's do that again!"
                mood_movie_search(mood_array, my_movies, api_key)
        end
    
        
    end
    
    
    # Message displayed when exiting the program
    def self.goodbye
    
        puts """
        ==========================================================
                                             |
                                  ___________I____________
                                 ( _____________________  )
                               _.-||                    ||
                           _.-'   ||                    ||
          ______       _.-'       ||                    ||
         |      |_ _.-'           ||                    ||
         |      |_|_              ||        fin         ||
         |______|   `-._          ||                    ||
            /|          `-._      ||                    ||
           / |              `-._  ||                    ||
          /  |                  `-||____________________||
         /   |                    ------------------------
        /____|_______________________|________________|______
        
        Thanks for using myMDb!
        =========================================================
        Developed by: Linda Lai and James Merrigan 
        """
        end



end