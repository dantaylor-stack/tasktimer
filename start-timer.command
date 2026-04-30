#!/bin/bash
# Task Timer — local server launcher
# Double-click this file to start the timer. Close the terminal window to stop the server.

cd "$(dirname "$0")"

PORT=8765

# If the port is already in use (e.g. you already have it running), just open the page.
if lsof -i :$PORT >/dev/null 2>&1; then
  echo "Task Timer is already running on port $PORT — opening browser."
  open "http://localhost:$PORT/index.html"
  exit 0
fi

# Open the browser shortly after the server starts.
( sleep 1 && open "http://localhost:$PORT/index.html" ) &

echo "Starting Task Timer at http://localhost:$PORT"
echo "Close this Terminal window to stop the server."
echo ""

# Prefer python3 (default on modern macOS); fall back to python.
if command -v python3 >/dev/null 2>&1; then
  exec python3 -m http.server $PORT --bind 127.0.0.1
else
  exec python -m SimpleHTTPServer $PORT
fi
