#!/bin/bash

eval $(xwininfo -id $(xdotool getactivewindow) | awk '
    /Absolute upper-left X/ {printf "X=%s ", $4}
    /Absolute upper-left Y/ {printf "Y=%s ", $4}
    /Width:/                {printf "W=%s ", $2}
    /Height:/               {printf "H=%s ", $2}
')

ffmpeg \
  -f x11grab -framerate 60 -video_size ${W}x${H} -i :0.0+${X},${Y} \
  -f pulse -i default \
  -c:v libx264 -preset veryfast -crf 23 \
  -c:a aac \
  /home/guts/videos/screen-recordings/window_with_audio.mp4

