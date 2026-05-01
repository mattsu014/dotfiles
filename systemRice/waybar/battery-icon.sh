
#!/bin/bash

BATTERY_PATH="/sys/class/power_supply/BAT0"
if [ ! -d "$BATTERY_PATH" ]; then
    BATTERY_PATH="/sys/class/power_supply/BAT1"
fi

while true; do
    if [ -d "$BATTERY_PATH" ]; then
        CAPACITY=$(cat "$BATTERY_PATH"/capacity)
        
        # Arredonda para dezena mais próxima (10, 20, 30... 100)
        if [ $CAPACITY -ge 95 ]; then
            LEVEL=100
        elif [ $CAPACITY -ge 85 ]; then
            LEVEL=90
        elif [ $CAPACITY -ge 75 ]; then
            LEVEL=80
        elif [ $CAPACITY -ge 65 ]; then
            LEVEL=70
        elif [ $CAPACITY -ge 55 ]; then
            LEVEL=60
        elif [ $CAPACITY -ge 45 ]; then
            LEVEL=50
        elif [ $CAPACITY -ge 35 ]; then
            LEVEL=40
        elif [ $CAPACITY -ge 25 ]; then
            LEVEL=30
        elif [ $CAPACITY -ge 15 ]; then
            LEVEL=20
        else
            LEVEL=10
        fi
        
        echo "{\"text\": \"${CAPACITY}%\", \"class\": \"battery-level-${LEVEL}\", \"percentage\": ${CAPACITY}}"
    else
        echo "{\"text\": \"\", \"class\": \"battery-missing\"}"
    fi
    
    sleep 10
done