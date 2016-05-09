#!/bin/bash

INPUT="${INPUT}"
CUSTOMER="${CUSTOMER}"
#EXTENSION="${EXTENSION}"
typeset -i CHUNK_LEN
CHUNK_LEN="${CHUNK_LEN}"

function usage {
        echo "Usage : ffsplit.sh input.file chunk-duration [output-filename-format]"
        echo -e "\t - input file may be any kind of file reconginzed by ffmpeg"
        echo -e "\t - chunk duration must be in seconds"
        echo -e "\t - output filename format must be printf-like, for example myvideo-part-%04d.avi"
        echo -e "\t - if no output filename format is given, it will be computed\
 automatically from input filename"
}
 
DURATION_HMS=$(ffmpeg -i "$INPUT" 2>&1 | grep Duration | cut -f 4 -d ' ')
DURATION_H=$(echo "$DURATION_HMS" | cut -d ':' -f 1)
DURATION_M=$(echo "$DURATION_HMS" | cut -d ':' -f 2)
DURATION_S=$(echo "$DURATION_HMS" | cut -d ':' -f 3 | cut -d '.' -f 1)
let "DURATION = ( DURATION_H * 60 + DURATION_M ) * 60 + DURATION_S"
 
if [ -z "$EXTENSION" ] ; then
        FILE_EXT=$(echo "$INPUT" | sed 's/^.*\.\([a-zA-Z0-9]\+\)$/\1/')
        FILE_NAME=$(echo "$INPUT" | sed 's/^\(.*\)\.[a-zA-Z0-9]\+$/\1/')
        EXTENSION="${FILE_NAME}-%03d.${FILE_EXT}"
        echo "Using default output file format : $EXTENSION"
fi
 
N='1'
OFFSET='0'
let 'N_FILES = DURATION / CHUNK_LEN + 1'
 
while [ "$OFFSET" -lt "$DURATION" ] ; do
        OUT_FILE=$(printf "$EXTENSION" "$N")
        echo "writing $OUT_FILE ($N/$N_FILES)..."
        ffmpeg -i "$INPUT" -vcodec copy -acodec copy -ss "$OFFSET" -t "$CHUNK_LEN" "$OUT_FILE"
        let "N = N + 1"
        let "OFFSET = OFFSET + CHUNK_LEN"
done