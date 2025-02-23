#!/usr/bin/env bash

set -ex

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <url> <s3-file-name>"
    exit 1
fi

~/software/yt-dlp_linux --update
FILE_NAME="$(~/software/yt-dlp_linux --quiet --no-warnings --get-filename --no-simulate "$1")"
gpg -r 'marcus.mueller.678@gmail.com' -o tmp.gpg --encrypt "$FILE_NAME"
aws s3 cp tmp.gpg 's3://backups-avid/'"$2".gpg --storage-class DEEP_ARCHIVE

echo 'https://eu-west-1.console.aws.amazon.com/s3/buckets/backups-avid'
