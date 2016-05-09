#!/bin/bash
case "${ROLE}" in
	        split)
            sh /scripts/split.sh
            ;;
        transcode)
            sh /scripts/transcode.sh
            ;;
        concat)
            sh /scripts/concat.sh
            ;;
esac