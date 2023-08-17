set -e -o pipefail

cd ~/keepassxc-storage
local_etag=$(cat etag)
remote_etag=$(aws --profile keepassxc-storage s3api head-object --bucket keepass-sync-test-5736622565ce --key db.tar|jq '.ETag' | sed 's/[^[:alnum:]]//g')

if [ $local_etag = $remote_etag ]; then
  tar c *.kdbx  | aws s3 cp - s3://keepass-sync-test-5736622565ce/db.tar
  rm etag
  aws --profile keepassxc-storage s3api head-object --bucket keepass-sync-test-5736622565ce --key db.tar|jq '.ETag' | sed 's/[^[:alnum:]]//g' >etag
  notify-send 'stored'
else
  notify-send -u critical -i "error" 'Etag mismatch'
fi
