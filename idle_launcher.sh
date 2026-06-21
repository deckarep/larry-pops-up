#!/bin/bash
# idle-launcher.sh
IDLE_SECONDS=$(ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print int($NF/1000000000); exit}')
THRESHOLD=300   # 5 minutes

if [ "$IDLE_SECONDS" -ge "$THRESHOLD" ]; then
    if ! pgrep -x "YourApp" > /dev/null; then
        open -a "/Applications/YourApp.app"
    fi
fi