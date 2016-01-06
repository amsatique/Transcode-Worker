#!/bin/bash
INPUT="$INPUT"
CUSTOMER="$CUSTOMER"
EXTENSION="$EXTENSION"
NAME=$(echo $INPUT | cut -d '.' -f1)
FFMPEG="ffmpeg -i /progress/$CUSTOMER/$INPUT"

mv /incomplete/$INPUT /progress/$CUSTOMER/$INPUT
if [ ! -d /complete/$CUSTOMER ];
then
  mkdir -p /complete/$CUSTOMER
fi

if [ -n "{$INPUT}" ];
then
  if [ -n "${NOVIDEO}" ];
  then
    NOVIDEO='-vn'
    FFMPEG=$FFMPEG $NOVIDEO
  fi
  if [ -n "${NOSOUND}" ];
  then
    NOSOUND='-an'
    FFMPEG=$FFMPEG $NOSOUND
  fi
  if [ -n "${BITRATE}" ];
  then
    BITRATE='-b:v ${BITRATE}k'
    FFMPEG=$FFMPEG $BITRATE
  fi
  if [ -n "${FRAMERATE}" ];
  then
    FRAMERATE='-r ${FRAMERATE}'
    FFMPEG=$FFMPEG $FRAMERATE
  fi
  FFMPEG="$FFMPEG /complete/$CUSTOMER/$NAME.$EXTENSION"
  $FFMPEG
  if [ -f /complete/$CUSTOMER/$NAME.$EXTENSION ]
  rm -f /imcomplete/$INPUT
fi
