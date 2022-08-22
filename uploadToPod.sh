#!/bin/bash

echo ">>>>🌸🌸🌸>>>>>>>[Release] start upgrading Cocoapod"
cp -r FinAppletWXExt.dist.podspec FinAppletWXExt.podspec
pod trunk push FinAppletWXExt.podspec --verbose
git checkout .
echo ">>>>🌸🌸🌸>>>>>>>[Release] end upgrading Cocoapod "



