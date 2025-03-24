#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

while IFS=, read year round winner opponent winner_goals opponent_goals
do
  if [[ $year != 'year' ]]
  then
    echo $($PSQL "INSERT INTO teams(name) VALUES('$winner')")
    echo $($PSQL "INSERT INTO teams(name) VALUES('$opponent')")
  fi
done < games.csv

while IFS=, read year round winner opponent winner_goals opponent_goals
do
  if [[ $year != 'year' ]]
  then
    winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
    opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
    echo $($PSQL "INSERT INTO games(year,round,winner_goals,opponent_goals,winner_id,opponent_id)
      VALUES($year,'$round',$winner_goals,$opponent_goals,$winner_id,$opponent_id)")
  fi
done < games.csv