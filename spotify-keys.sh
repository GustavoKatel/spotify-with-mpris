#!/bin/bash


PUSH_TO_SPOTIFY=true

mpris-remote identity 2>&1 1> /dev/null

if [[ $? == 0 ]]
then
  PUSH_TO_SPOTIFY=false;
fi

PLAYING=true

if [ $PUSH_TO_SPOTIFY = false ]; then
  STATUS=$(mpris-remote playstatus | head -n 1)

  echo $STATUS
  if [[ $STATUS != *"playing: playing"* ]]
  then
    PLAYING=false;
  fi

fi

function play_pause {
  if [[ $PUSH_TO_SPOTIFY == true ]]
  then
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause 2>&1 > /dev/null
  else

    if [[ $PLAYING == true ]]
    then
      mpris-remote pause
    else
      mpris-remote play
    fi
  fi
}

function stop {
  if [[ $PUSH_TO_SPOTIFY == true ]]
  then
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop 2>&1 > /dev/null
  else

    if [[ $PLAYING == true ]]
    then
      mpris-remote stop
    else
      mpris-remote play
    fi
  fi
}

function next {
  if [[ $PUSH_TO_SPOTIFY == true ]]
  then
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next 2>&1 > /dev/null
  else
    mpris-remote next
  fi
}

function previous {
  if [[ $PUSH_TO_SPOTIFY == true ]]
  then
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous 2>&1 > /dev/null
  else
    mpris-remote previous
  fi
}

ARG=$1

case $ARG in
  PlayPause)
    play_pause
    ;;
  Stop)
    stop
    ;;
  Next)
    next
    ;;
  Previous)
    previous
    ;;
  \?)
    echo "Invalid"
    ;;
esac
