#!/bin/bash

qmake -spec android-clang
# sudo needed for some /opt stuff
sudo make aab -j9
# move the apk to here
mv android-build/build/outputs/apk/debug/android-build-debug.apk qtodo.apk

echo Releasing under name `git tag | tail -n 1`

# release the APK on github
# (github key in .env)
releaseme/releaseme.sh -n `git tag | tail -n 1` -f qtodo.apk -m application/zip -r swissChili/qtodo
