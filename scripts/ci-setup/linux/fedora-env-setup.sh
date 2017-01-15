#!/usr/bin/env bash

dnf -y --quiet update
dnf -y --quiet install qt5-qtquickcontrols2-devel gcc-c++ cmake git lcov findutils
git submodule update --init --recursive