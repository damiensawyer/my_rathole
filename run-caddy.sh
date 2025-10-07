#!/bin/bash

cleanup() {
    echo "Shutting down services..."
    # Kill both processes if they're still running
    [ -n "$RATHOLE_PID" ] && kill $RATHOLE_PID 2>/dev/null
    [ -n "$CADDY_PID" ] && kill $CADDY_PID 2>/dev/null
    # Wait briefly for graceful shutdown
    sleep 1
    # Force kill if still running
    [ -n "$RATHOLE_PID" ] && kill -9 $RATHOLE_PID 2>/dev/null
    [ -n "$CADDY_PID" ] && kill -9 $CADDY_PID 2>/dev/null
    exit 0
}

# Trap SIGTERM and SIGINT to kill child processes
trap cleanup SIGTERM SIGINT

# Run rathole server in the background
./rathole server.toml &
RATHOLE_PID=$!

# Run Caddy in the background
caddy run --config Caddyfile --adapter caddyfile &
CADDY_PID=$!

# Wait for both processes
wait -n

# If one exits, kill the other
cleanup
