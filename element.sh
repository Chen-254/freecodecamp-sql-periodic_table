#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
  if [[ $1 ]]
  then
    if [[ ! $1 =~ ^[0-9]+$ ]]
    then
      ELEMENT_DETAILS=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1'")
      if [[ -z $ELEMENT_DETAILS ]]
      then
        ELEMENT_DETAILS=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1'")
        if [[ -z $ELEMENT_DETAILS ]]
        then
          echo "I could not find that element in the database."
        else
          echo "$ELEMENT_DETAILS" | while read ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
        fi
      else
        echo "$ELEMENT_DETAILS" | while read ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
    else
      ELEMENT_DETAILS=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")
      #if no such atomic number
      if [[ -z $ELEMENT_DETAILS ]]
      then
        echo "I could not find that element in the database."
      else
        echo "$ELEMENT_DETAILS" | while read ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
    fi
  else
    echo "Please provide an element as an argument."
  fi
