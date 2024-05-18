#!/bin/bash

# A number guessing game that uses a PSQL database to
# hold user data pertaining to their game performance.
# We interact through a CLI and guess a number that
# is selected using the Random environment variable.

# Connect to the newly created database
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

GUESS_COUNT=1 # our current guess default


GET_GUESS() {
# Evaluate their pick until they guess correctly
  # read in user's pick
  read GUESS
  # check that input is number
  if [[ $GUESS =~ ^[0-9]+$ ]]
  then
    # it is:
      # guessed exactly 
      if [[ $GUESS -eq $RANDOM_NUMBER ]]
      then
        echo "You guessed it in $GUESS_COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"
      # too high 
      elif [[ $GUESS -gt $RANDOM_NUMBER ]]
      then
        # message that they're too high
        # get new guess
        echo "It's lower than that, guess again: "
        ((GUESS_COUNT++))
        GET_GUESS
      # too low 
      else
        # message that they're too low 
        # get new guess
        echo "It's higher than that, guess again: "
        ((GUESS_COUNT++))
        GET_GUESS
      fi
  else
    # it isn't:
    # prompt for actual number
    echo "That is not an integer, guess again: "
    ((GUESS_COUNT++))
    GET_GUESS
  fi
}

# Generate a random number between 1 and 1000
RANDOM_NUMBER=$((1 + RANDOM % 1000))

# Get user input
echo "Enter your username: "
read USERNAME

# Check database for if user has made a guess before
SEARCH_FOR_USER_QUERY="SELECT * FROM users WHERE username='$USERNAME'"
SEARCH_FOR_USER=$($PSQL "$SEARCH_FOR_USER_QUERY")
  if [[ ! -z $SEARCH_FOR_USER ]]
  then # they have
    echo $SEARCH_FOR_USER | while read ID BAR USERNAME BAR GAMES_PLAYED BAR BEST_GAME
    do
      echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    done
  else # they haven't
    echo "Welcome, $USERNAME! It looks like this is your first time here."
  fi

# Get their pick
# show prompt
echo "Guess the secret number between 1 and 1000: "
GET_GUESS $RANDOM_NUMBER 0

# if the user is new to the game, then we add them. 
if [[ -z $SEARCH_FOR_USER ]]
then # insert new user with their attempts
  INSERT_NEW_USER_QUERY="INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 1, $GUESS_COUNT);"
  INSERT_NEW_USER=$($PSQL "$INSERT_NEW_USER_QUERY")
else # update returning user's games_played and if needed update best_game
  UPDATE_USER_QUERY="UPDATE users SET games_played = games_played + 1 WHERE username='$USERNAME'; UPDATE users SET best_game = LEAST(best_game, $GUESS_COUNT) WHERE username='$USERNAME';"
  UPDATE_USER=$($PSQL "$UPDATE_USER_QUERY")
fi