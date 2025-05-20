#!/bin/bash

# Define the session name and directories
SESSION_NAME="sample session name"
CODE_DIR="$HOME/Documents/Code"
CONTENT_DIR="$HOME/Documents/Resources"
DOCUMENTATION="$HOME/Documents/Documentation"

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

    # edit
    tmux new-window -t $SESSION_NAME -n edit
    tmux send-keys -t $SESSION_NAME:2 "cd $CODE_DIR" C-m
    tmux send-keys -t $SESSION_NAME:2 "clear" C-m

    # content
    tmux new-window -t $SESSION_NAME -n content
    tmux send-keys -t $SESSION_NAME:3 "cd $CONTENT_DIR" C-m
    tmux send-keys -t $SESSION_NAME:3 "clear" C-m

    # documentation 
    tmux new-window -t $SESSION_NAME -n documentation
    tmux send-keys -t $SESSION_NAME:4 "cd $DOCUMENTATION && clear && echo 'Welcome Back!'" C-m

    # code
    tmux send-keys -t $SESSION_NAME:1 "cd $CODE_DIR && clear && vim" C-m


    # Attach to the session
    tmux attach-session -t $SESSION_NAME
fi
