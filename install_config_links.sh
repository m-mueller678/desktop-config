#!/usr/bin/env bash

cd "$(dirname "$0")"

for x in $(find . -type f | grep -v 'install_config_links\.sh\|\.git')
do
echo ln -sf $PWD/$x ~/$x
done
