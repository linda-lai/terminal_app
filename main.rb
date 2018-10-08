# Require in methods and movie array modules
require_relative './methods'
require_relative './randomiser'

# Need to set a variable that pulls an environment variable
# This is used to store the API key for pulling data from OMDB
omdb_api_key = ENV["OMDB_API_KEY"]

# Creates condition for running application
exit_program = false

# Empty array to store movie favourites
my_movies = []

# Used TTY Font gem for myMDB logo
font = TTY::Font.new(:standard)

# Used TTY Spinner gem for 'Loading' graphic
spinner = TTY::Spinner.new("[:spinner] Loading ...", format: :pulse_2)

# 'While' loop for iterating through menu options/application
# Loop will run until '4' is selected
while exit_program == false

    # Prints main menu for initial user selection
    Methods.main_menu(font, spinner)
    # Prompts user for main menu input
    selection = gets.chomp.to_i

    # Conditionals for navigating through application methods
    if selection == 1
        spinner.auto_spin
        sleep 1
        spinner.stop
        # Calls 'search_for_movie' method, takes in 'my_movies' empty array if user opts to save selections
        Methods.search_for_movie(my_movies, omdb_api_key)
    elsif selection == 2
        spinner.auto_spin
        sleep 1
        spinner.stop
        # Calls 'display_movie_list method, takes in 'my_movies' array and formats output display
        Methods.display_movie_list(my_movies)
    elsif selection == 3
        spinner.auto_spin
        sleep 1
        spinner.stop
        # Calls 'mood_movie_search' with 'Methods.mood_choice' arrays as an argument
        # Presents a list of moods to user to select, will choose random index from selected array and return movie suggestion
        Methods.mood_movie_search(Methods.mood_choice(Movies.joy, Movies.melancholy, Movies.nostalgic, Movies.futuristic, Movies.strange, Movies.netflix, Movies.thriller), my_movies, omdb_api_key)
    elsif selection == 4
        sleep 1
        # Displays 'fin' Ascii art
        Methods.goodbye
        # Changes 'exit_program' boolean
        exit_program = true
        break
    else
        # If user selects anything other than 1-4 from main menu
        puts "Ru-roh! Bad selection, please try again."
        sleep 1
    end
    
end