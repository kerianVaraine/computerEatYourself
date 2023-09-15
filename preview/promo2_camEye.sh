#!/bin/bash
clear

#init camera feed
  clear  
printf "\n\n\n\n\n"
figlet -t -r -f future Beginning video capture...

#split window vertically #TODO: proper alignment of splits etc
tmux split-window -v -p 10;
#Get name of pane and set as variable
VIDEOCAPTUREPANE=$(tmux display-message -p "#{pane_id}") 
#go back to pane 0
tmux select-pane -t 0;
#send command to pane
tmux send-keys -t $VIDEOCAPTUREPANE "rm wc.bmp;ffmpeg -r 3 -s 640x480 -f video4linux2 -i /dev/video0 -f image2 -update 1 ./wc.bmp" ENTER;

sleep 4

#display webcam feed
clear
printf "\n\n\n\n"
figlet -t -r -f future Displaying death...
#split window vertically #TODO: proper alignment of splits etc
tmux split-window -v -p 80;
DISPLAYPANE=$(tmux display-message -p "#{pane_id}")
#select original pane
tmux select-pane -t 0;
#send command pane just made, also watch the chafa process and relaunch if it crashes. see stackoverflow: re-run an application script when it crashes?
tmux send-keys -t $DISPLAYPANE "while true; do chafa --watch wc.bmp && break; done" ENTER;

# To send ctrl-c to pane, usefull for exiting amidiplay for intromusic
# tmux send-keys -t TARGETPANE C-c
#
#init souP
clear
printf "\n\n\n\n"


sleep 26

figlet -t -r -f future NOT YET
#split window vertically #TODO: proper alignment of splits etc
tmux split-window -v -p 5;
SOUPPANE=$(tmux display-message -p "#{pane_id}")
#select original pane
tmux select-pane -t 0;
#send command to pane 2 just made
tmux send-keys -t $SOUPPANE "./souP wc.bmp" ENTER

sleep 4
printf "\n\n\n\n\n\n\n\n\n\n\n"

#
#
tmux kill-pane -a -t 0

exit 0

