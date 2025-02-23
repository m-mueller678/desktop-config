#!/usr/bin/env bash

~/software/yt-dlp_linux --update
echo
echo
echo ~/software/yt-dlp_linux "$1"
echo gpg -r 'marcus.mueller.678@gmail.com' -o tmp.gpg --encrypt "<in-name>"
echo aws s3 cp tmp.gpg 's3://backups-avid/'"<s3-name>".gpg --storage-class DEEP_ARCHIVE
echo 'https://eu-west-1.console.aws.amazon.com/s3/buckets/backups-avid'
