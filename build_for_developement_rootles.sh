#/bin/sh

#	build for rootless jailbreaks
make clean
make package THEOS_PACKAGE_SCHEME=rootless
