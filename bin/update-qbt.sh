#!/bin/bash

# stop if we fail
set -e

# ensure build succeeds
NO_OVERRIDES=1 qbt build --package meta_tools.release --verify

if [[ -d qbt ]]; then
    git rm -rf qbt
fi

NO_OVERRIDES=1 qbt build --package meta_tools.release --verify --output requested,directory,$(pwd)/qbt

git add qbt

