#!/bin/sh
# Description: Checkout seed branches and remove blacklisted packages

dist="$1"

apt-get install --no-install-recommends -f -q -y git

git clone --depth 1 https://github.com/elementary/seeds.git --single-branch --branch "$dist"
git clone --depth 1 https://github.com/elementary/platform.git --single-branch --branch "$dist"

for package in $(cat 'platform/blacklist' 'seeds/blacklist' | grep -v '#'); do
    apt-get autoremove --purge -f -q -y "$package"
done

apt-get autoremove --purge -f -q -y git

rm -R ./seeds ./platform