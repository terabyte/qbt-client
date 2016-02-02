#!/bin/bash

set -e

# usage:
# fetch-and-update-package.sh <remote> <remote ref> <package> <output dir>
# e.g. fetch-and-update-package.sh origin master meta_tools.release $HOME/opt/qbt

REMOTE=$1
REF=$2
PKG=$3
OUTPUT_DIR=$4
CURRENT="unknown"
DATE="$(date +"%Y%m%d%H%M%S")"

if [[ -f "$OUTPUT_DIR/qbt.versionDigest" ]]; then
    CURRENT=$(cat $OUTPUT_DIR/qbt.versionDigest)
fi

git -C meta fetch $REMOTE $REF

git -C meta checkout FETCH_HEAD

# calculate new version
NEWVERSION="$(qbt resolveManifestCumulativeVersions --package $PKG | cut -d' ' -f2)"

if [[ "$CURRENT" == "$NEWVERSION" ]]; then
    exit 0
fi
echo "Updating from version $CURRENT to version $NEWVERSION"

# confirm build succeeds first
qbt build --package $PKG --verify

function cleanup {
    if [[ ! -d $OUTPUT_DIR ]]; then
        mv $OUTPUT_DIR.$DATE $OUTPUT_DIR
    fi
    # save old copies by default
    #rm -rf $OTUPUT_DIR.$DATE
}
trap cleanup EXIT

if [[ -d $OUTPUT_DIR ]]; then
    # move out of the way
    mv $OUTPUT_DIR $OUTPUT_DIR.$DATE
fi
qbt build --package $PKG --output requested,directory,$OUTPUT_DIR


