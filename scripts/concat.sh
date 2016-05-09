#!/bin/bash
INPUT="${INPUT}"
CUSTOMER="${CUSTOMER}"
EXTENSION="${EXTENSION}"
NAME=$(echo $INPUT | cut -d '.' -f1)


#Examples
#ffmpeg -f concat -i <(for f in ./*.wav; do echo "file '$PWD/$f'"; done) -c copy output.wav
#ffmpeg -f concat -i <(printf "file '$PWD/%s'\n" ./*.wav) -c copy output.wav
#ffmpeg -f concat -i <(find . -name '*.wav' -printf "file '$PWD/%p'\n") -c copy output.wav

ffmpeg -f concat -i <(for f in /data/progress/$CUSTOMER/$NAME*.$EXTENSION; do echo "file '$PWD/$f'"; done) -c copy /data/complete/$CUSTOMER/$NAME.$EXTENSION

# Check end of build and flush data folder
if [ -f /data/complete/$CUSTOMER/$NAME.$EXTENSION ];
then
rm -f /data/progress/$CUSTOMER/$NAME*.$EXTENSION
fi

exit
