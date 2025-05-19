#                   Expected params and behaviour
# This scripts serves to check if a target tmux session name exists
# As tmux "has-session -t" returns 0 if any char of the target of the target session exist in an existing session
# As an example session for a session name "my" 
# "tmux has-session -t "m"" return 0

# @param session-name - The target sessions name
# @return 0 - target session exists
# @return 1 - target session does not exist or there are no sessions running 
# @return 2 - incorrect number of paramaters


TMUX_SESSIONS=$(tmux ls 2>&1)
IFS="" # The delimeter for $*
TARGET_SESSION=$*

#Ensure a target session is passed
if [ $# -lt 1 ]; then 
    echo "No target session passed"
    exit 2
#Ensure there are sessions running 
elif [ "$TMUX_SESSIONS" = "no server running on /tmp/tmux-1000/default" ]; then
    echo "There are currently no sessions running"
    exit 1
fi

check_session_exists() {

    IFS=$'\n'
    for SESSION in ${TMUX_SESSIONS}; do
      # Compare the session name with the target string
      SESSION=${SESSION%%:*}
      if [ "$SESSION" == "$TARGET_SESSION" ]; then
          exit 0 #HIT
      fi
    done

    echo "There is no tmux session "$TARGET_SESSION" currently running"
    exit 1
}

check_session_exists
