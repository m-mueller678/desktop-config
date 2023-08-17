set -e -o pipefail

# to set credentials:
# aws configure --profile 
# Default region name [None]: eu-west-1
# Default output format [None]: json

cd ~/keepassxc-storage
etag=$(aws --profile keepassxc-storage s3api head-object --bucket keepass-sync-test-5736622565ce --key db.tar|jq '.ETag' | sed 's/[^[:alnum:]]//g')
echo $etag
aws s3 cp --profile keepassxc-storage s3://keepass-sync-test-5736622565ce/db.tar - | tar -x
echo $etag>etag
notify-send "loaded $etag"
