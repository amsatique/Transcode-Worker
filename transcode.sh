#!/bin/bash
INPUT="$INPUT"
CUSTOMER="$CUSTOMER"
EXTENSION="$EXTENSION"
NAME=$(echo $INPUT | cut -d '.' -f1)
FFMPEG="ffmpeg -i /data/progress/$CUSTOMER/$INPUT"

if [ ! -d /data/complete/$CUSTOMER ];
then
  mkdir /data/complete/$CUSTOMER
fi
if [ ! -d /data/progress/$CUSTOMER ];
then
  mkdir /data/progress/$CUSTOMER
fi

mv /data/incomplete/$INPUT /data/progress/$CUSTOMER/

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

  FFMPEG="$FFMPEG /data/complete/$CUSTOMER/$NAME.$EXTENSION"
  $FFMPEG

  if [ -f /data/complete/$CUSTOMER/$NAME.$EXTENSION ];
  then
  rm -f /data/incomplete/$INPUT
  rm -rf /data/progress/$CUSTOMER
  fi
fi
