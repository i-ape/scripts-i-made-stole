#!/bin/bash

while true; do
    # Generate a random number of seconds (up to 24 hours)
    SECONDS_IN_A_DAY=$((24 * 60 * 60))
    RANDOM_WAIT_TIME=$((RANDOM % SECONDS_IN_A_DAY))

    # Wait for the random time period
    sleep $RANDOM_WAIT_TIME

    # Display Roman reminders
   SAYINGS=(
             "Memento mori. Remember that you must die."
             "Look behind you, remember you are only a man.")

    RANDOM_INDEX=$((RANDOM % ${#SAYINGS[@]}))

    # Display the random saying
    echo "${SAYINGS[$RANDOM_INDEX]}"


    # Reset for the next day
done


## to run chmod +x rr.sh
