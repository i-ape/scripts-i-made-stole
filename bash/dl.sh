#!/bin/bash

while true; do
    # Generate a random number of seconds (up to 24 hours)
    SECONDS_IN_A_DAY=$((24 * 60 * 60))
    RANDOM_WAIT_TIME=$((RANDOM % SECONDS_IN_A_DAY))

    # Wait for the random time period
    sleep $RANDOM_WAIT_TIME

    # Display the Dalai Lama message
    echo "You are only a man."

    # Reset for the next day
done


## to run chmod +x dalai_lama.sh
