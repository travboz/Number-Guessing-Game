# Periodic Table Database created using PostgreSQL and Bash
This repository contains the code used to create a number guessing game using Bash. We use a CLI to play the game and interact with the PSQL database.

## Dependencies
- [PostgreSQL](https://www.postgresql.org/download/)
- [Bash](https://www.gnu.org/software/bash/)

## Installation
- Clone this repo: 
`git clone https://github.com/travboz/Number-Guessing-Game.git`.

- Navigate into your project directory: 
`cd your_project_folder/Number-Guessing-Game` (for example).

- Building the database
When in the folder containing the `number_guess.sql` file, run the following command to create and populate the database:
`psql -U postgres < number_guess.sql`

- Playing the game:
After building the database, run the `number_guess.sh` script to play the game.
Enter a username (of length up to 22 characters) and try to guess the numnber.
Run the `element.sh` shell script. Run it as follows:

Using a program like [pgAdmin](https://www.pgadmin.org/download/) you can inspect the architecture of the database. Alternatively, you can use SQL queries to explore.

There exists one table with the table containing data pertaining to user performance in the game.

| Table Name  | Description                                                                                                           |
|-------------|-----------------------------------------------------------------------------------------------------------------------|
| `users`     | Performance data of users who have played the game. |

This project was created to follow the FreeCodeCamp certification project.

Project link: [Number Guesing Game](https://www.freecodecamp.org/learn/relational-database/build-a-number-guessing-game-project/build-a-number-guessing-game)
