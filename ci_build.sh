#!/usr/bin/env bash

if [ $BUILD_TYPE == "default" ]; then
    #   Build required projects first

    #   libsodium
    git clone git://github.com/jedisct1/libsodium.git
    ( cd libsodium; ./autogen.sh; ./configure; make check; sudo make install;
        if [ $TRAVIS_OS_NAME != "osx" ] ; then sudo ldconfig ; fi )

    #   Build and check this project
    (./autogen.sh && ./configure --with-libsodium=yes && make && make check && sudo make install) || exit 1
else
    cd ./builds/${BUILD_TYPE} && ./ci_build.sh
fi
