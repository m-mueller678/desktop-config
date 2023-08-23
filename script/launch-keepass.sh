#!/usr/bin/bash
set -e -o pipefail
~/script/keepassxc-storage-load.sh
keepassxc
~/script/keepassxc-storage-store.sh
