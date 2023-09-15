#!/bin/bash
beep -f 500 -l 100
clear
#: <<'END_COMMENT'

printf "\n\n\n\n\n\n\n\n"
printf "Computer: Eat Yourself.\n\n"
printf "Photo-sensitivity  warning:\nSome flashing happens in this.\nIs that OK?\n"
read -r -p "(yes/no)" prompt
if [[ "$prompt" =~ [yY](es)* ]]
  then
    printf "\nGreat"
    sleep 1
    printf "."
    sleep 1
    printf "."
    sleep 1
    printf "."
    sleep 1
    clear

    printf "\n\n\n\n\n\n\n\n"
    figlet -t -l -f wideterm Computer?
    sleep 2
    figlet -t -r -f future Yes?
    sleep 2
    figlet -t -c -f wideterm Eat Yourself
    figlet -t -c -f wideterm Please
    sleep 3
    figlet -t -c -f future of course
    sleep 5
  else
    printf "Sweet as, good luck out there."
    exit 0
  fi
# END_COMMENT

#init camera feed
  clear  
printf "\n\n\n\n\n"
figlet -t -r -f future Beginning video capture...

#split window vertically #TODO: proper alignment of splits etc
tmux split-window -v -p 5;
#Get name of pane and set as variable
VIDEOCAPTUREPANE=$(tmux display-message -p "#{pane_id}") 
#go back to pane 0
tmux select-pane -t 0;
#send command to pane
tmux send-keys -t $VIDEOCAPTUREPANE "rm wc.bmp;ffmpeg -r 3 -s 1024x800 -f video4linux2 -i /dev/video0 -f image2 -update 1 ./wc.bmp" ENTER;

sleep 4

#init souP
clear
printf "\n\n\n\n"

figlet -t -r -f future Turning into souP...
#split window vertically #TODO: proper alignment of splits etc
tmux split-window -v -p 5;
SOUPPANE=$(tmux display-message -p "#{pane_id}")
#select original pane
tmux select-pane -t 0;
#send command to pane 2 just made
tmux send-keys -t $SOUPPANE "./souP wc.bmp" ENTER

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
#tmux send-keys -t $DISPLAYPANE "while true; do chafa --stretch --watch wc.bmp && break; done" ENTER;
tmux send-keys -t $DISPLAYPANE "feh --borderless -g 1024x800+0+220 --reload 1 --zoom fill --quiet wc.bmp" ENTER;


# To send ctrl-c to pane, usefull for exiting amidiplay for intromusic
# tmux send-keys -t TARGETPANE C-c
#
#
#
#

printf "\n\n\n\n hit enter to kill all panes"
read
tmux kill-pane -a -t 0

exit 0

#screen recording
# ffmpeg -video_size 1024x1280 -framerate 30 -f x11grab -i :0.0+0,0 -c:v libx264rgb -crf 0 -preset ultrafast sample.mkv
