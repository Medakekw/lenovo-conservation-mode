#!/bin/bash

FILE="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

if [ ! -e "$FILE" ]; then
    echo "Error: $FILE does not exist."
    exit 1
fi

if [ -r "$FILE" ]; then
    CURRENT_VALUE=$(cat "$FILE")
    if [ "$CURRENT_VALUE" -eq 1 ]; then
        echo "Conservation Mode is currently ON."
    else
        echo "Conservation Mode is currently OFF."
    fi
else
    echo "Error: Cannot read $FILE. Permission denied."
    exit 1
fi

echo -n "Do you want to set a new value? (on/off/exit): "
read USER_INPUT

case "$USER_INPUT" in
    on|On|ON)
        echo "Setting Conservation Mode to ON..."
        echo 1 | sudo tee "$FILE" >/dev/null
        ;;
    off|Off|OFF)
        echo "Setting Conservation Mode to OFF..."
        echo 0 | sudo tee "$FILE" >/dev/null
        ;;
    exit|Exit|EXIT)
        echo "Exiting without changes."
        ;;
    *)
        echo "Invalid input. Please enter 'on', 'off', or 'exit'."
        ;;
esac