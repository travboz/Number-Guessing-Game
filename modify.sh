#!/bin/bash

# Purpose of this script is to create the database to which we modify and use to access returning user data.
# We connect to the base PostgreSQL DB, create the new database, and populate with a table and some dummy data.

# PSQL
PSQL="psql -X --username=freecodecamp --dbname=postgres --tuples-only -c"

# Create a new database
$PSQL "CREATE DATABASE number_guess;"

# Connect to the newly created database
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

# # Create a table in the database
$PSQL "CREATE TABLE users (user_id SERIAL PRIMARY KEY, username VARCHAR(22) UNIQUE NOT NULL, games_played INT DEFAULT 0, best_game INT);"

# # Test insert
$PSQL "INSERT INTO users(username, best_game) VALUES('travbbb', 10);"