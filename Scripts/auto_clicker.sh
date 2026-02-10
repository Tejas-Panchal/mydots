#!/bin/bash

# Auto-clicker toggle with proper process management
# Improved version with PID tracking, error handling, and graceful shutdown

set -euo pipefail

# Configuration
PID_FILE="$HOME/.local/cache/autoclicker.pid"
SOCKET_PATH="$HOME/.ydotool_socket"
CLICK_DELAY=0.01  # Small delay to prevent CPU saturation
CLICK_CODE=0xC0    # Left mouse button

# Cleanup function for graceful exit
cleanup() {
    if [[ -f "$PID_FILE" ]]; then
        local pid
        pid=$(cat "$PID_FILE" 2>/dev/null || echo "")
        if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
            kill -TERM "$pid" 2>/dev/null || true
            wait "$pid" 2>/dev/null || true
        fi
        rm -f "$PID_FILE"
    fi
    notify-send "Auto-clicker stopped"
    exit 0
}

# Signal handlers
trap cleanup SIGTERM SIGINT

# Check dependencies
check_dependencies() {
    if ! command -v ydotool >/dev/null 2>&1; then
        notify-send "Error: ydotool not found"
        exit 1
    fi
    if ! command -v ydotoold >/dev/null 2>&1; then
        notify-send "Error: ydotoold not found"
        exit 1
    fi
    if ! command -v notify-send >/dev/null 2>&1; then
        echo "Warning: notify-send not found"
    fi
}

# Ensure cache directory exists
mkdir -p "$(dirname "$PID_FILE")"

# Check if auto-clicker is already running
if [[ -f "$PID_FILE" ]]; then
    pid=$(cat "$PID_FILE" 2>/dev/null || echo "")
    if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
        # Process is running, stop it
        kill -TERM "$pid"
        wait "$pid" 2>/dev/null || true
        rm -f "$PID_FILE"
        # notify-send "Auto-clicker stopped"
        exit 0
    else
        # Stale PID file, remove it
        rm -f "$PID_FILE"
    fi
fi

# Check dependencies
check_dependencies

# Start daemon if not already running
if ! pgrep -f "ydotoold.*$SOCKET_PATH" >/dev/null 2>&1; then
    if ! sudo -b ydotoold --socket-path="$SOCKET_PATH" --socket-own="$(id -u):$(id -g)" >/dev/null 2>&1; then
        notify-send "Error: Failed to start ydotoold daemon"
        exit 1
    fi
    # Give daemon time to initialize
    sleep 0.5
fi

# Validate socket is accessible
if [[ ! -S "$SOCKET_PATH" ]]; then
    notify-send "Error: ydotool socket not found"
    exit 1
fi

# Start auto-clicker in background
(
    # notify-send "Auto-clicker started"
    
    # Click loop with small delay
    while true; do
        YDOTOOL_SOCKET="$SOCKET_PATH" ydotool click "$CLICK_CODE" >/dev/null 2>&1 || true
        sleep "$CLICK_DELAY"
    done
) &

# Store the background process PID
AUTOCLICK_PID=$!
echo "$AUTOCLICK_PID" > "$PID_FILE"

exit 0
