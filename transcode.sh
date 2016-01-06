#!/bin/bash
INPUT="$INPUT"
#INPUT=test.avi # A retirer
EXTENSION="$EXTENSION"
NAME=$(echo $INPUT | cut -d '.' -f1)
FFMPEG=ffmpeq -y -i /incomplete/$INPUT
if [-z "$INPUT"];
then
  if [-z "${NOVIDEO}"];
  then
    NOVIDEO='-vn'
    FFMPEG=$FFMPEG $NOVIDEO
  fi
  if [-z "${NOSOUND}"];
  then
    NOSOUND='-an'
    FFMPEG=$FFMPEG $NOSOUND
  fi
  if [-z "${BITRATE}"];
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
