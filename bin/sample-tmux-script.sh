#!/bin/bash

# Define the session name and directories
SESSION_NAME="server-impl"
CODE_DIR="$HOME/Documents/Projects/git-repos/server/c-server/src"
CONTENT_DIR="$HOME/Documents/Projects/git-repos/server/c-server/src/html"
DOCUMENTATION="$HOME/Documents/Projects/git-repos/server/documentation"

#Scripts
HAS_TARGET_SESSION="/home/guts/bin/tmux/check-session-exists.sh"

# Check if the session already exists 
"$HAS_TARGET_SESSION" "$SESSION_NAME"
SESSION_EXISTS=$?

if [ $SESSION_EXISTS -eq 0 ]; then
  # Session exists, attach to it
  echo "attacht"
  tmux attach-session -t $SESSION_NAME
else
  echo "create"
    # Start a new tmux session
    tmux new-session -d -s $SESSION_NAME 

    # compile
    tmux send-keys -t $SESSION_NAME:1 "cd $CODE_DIR && clear && gcc http_server.c -o http_server" C-m
    tmux send-keys -t $SESSION_NAME:1 "clear" C-m
    tmux send-keys -t $SESSION_NAME:1 "gcc http_server.c -o http_server" C-m

    # edit
    tmux new-window -t $SESSION_NAME -n edit
    tmux send-keys -t $SESSION_NAME:2 "cd $CODE_DIR" C-m
    tmux send-keys -t $SESSION_NAME:2 "clear" C-m

    # content
    tmux new-window -t $SESSION_NAME -n content
    tmux send-keys -t $SESSION_NAME:3 "cd $CONTENT_DIR" C-m
    tmux send-keys -t $SESSION_NAME:2 "clear" C-m

    # documentation 
    tmux new-window -t $SESSION_NAME -n documentation
    tmux send-keys -t $SESSION_NAME:4 "cd $DOCUMENTATION && clear && echo 'Welcome back to the server construction session!'" C-m

    # Attach to the session
    tmux attach-session -t $SESSION_NAME
fi
