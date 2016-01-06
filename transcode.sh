#!/bin/bash
INPUT="$INPUT"
#INPUT=test.avi # A retirer
EXTENSION="$EXTENSION"
NAME=$(echo $INPUT | cut -d '.' -f1)
FFMPEG=ffmpeq -i /incomplete/$INPUT
if [-n "{$INPUT}"];
then
  if [-n "${NOVIDEO}"];
  then
    NOVIDEO='-vn'
    FFMPEG=$FFMPEG $NOVIDEO
  fi
  if [-n "${NOSOUND}"];
  then
    NOSOUND='-an'
    FFMPEG=$FFMPEG $NOSOUND
  fi
  if [-n "${BITRATE}"];
  then
    BITRATE='-b:v ${BITRATE}k'
    FFMPEG=$FFMPEG $BITRATE
  fi
  if [-z "${FRAMERATE}"];
  then
    FRAMERATE='-r ${FRAMERATE}'
    FFMPEG=$FFMPEG $FRAMERATE
  fi
  FFMPEG=$FFMPEG /complete/$NAME.$EXTENSION
  $FFMPEG
else
  bin/bash
fi
