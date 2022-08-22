#!/bin/bash -l

export LANG=en_US.UTF-8
export FASTLANE_DISABLE_COLORS=1

#version=`git tag -l --sort=committerdate  |awk 'END {print}' | tr -d '\\n' | tr -d '\\t'`

if [ -z "$version" ]
then 

echo "❇️❇️❇️❇️❇️ 版本号为空，从git获取"
version=`git describe --abbrev=0 --tags | tr -d '\\n' | tr -d '\\t'`

fi

echo "❇️❇️❇️❇️❇️ 当前版本: ${version}"
#git reset --hard
#git checkout ${version}

git add .
git commit -m "version++"
git tag -d ${version}
git push origin --delete tag ${version}
git tag -a ${version} -m 'FinAppletWXExt发版'
git push origin HEAD:refs/heads/master --tags -f


# 开始打Release版SDK
cp -r Podfile.tpl Podfile
sed -i "" "s/__finapplet_version__/${version}/g" Podfile

pod update
rm -rf build dist


fastlane deploy


# 修改podspec文件
cp -r FinAppletWXExt.tpl.podspec FinAppletWXExt.podspec
sed -i "" "s/_FFinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec
# 内存拷贝进FinApplet.dist.podspec 便于查看打出的framework
cp -f FinAppletWXExt.podspec FinAppletWXExt.dist.podspec


echo ">>>>🍎🍎🍎🍎>>>>>[Release] upgrading FinPods start"
git clone ssh://git.finogeeks.club/finoapp-ios/FinPods
rm -rf FinPods/FinAppletWXExt/${version}

mkdir -p FinPods/FinAppletWXExt/${version}
cp FinAppletWXExt.podspec FinPods/FinAppletWXExt/${version}/FinAppletWXExt.podspec
cd FinPods

git add FinAppletWXExt/${version} && git commit -m "upgrade FinAppletWXExt ${version}" && git push

cd ..
rm -rf FinPods
echo ">>>>🍎🍎🍎🍎>>>>>>>[Release] upgrading FinPods end"


echo "❤️❤️❤️❤️ creat FinAppletWXExt code podspec start"
cp -r FinAppletWXExt.code.tpl.podspec FinAppletWXExt.podspec
sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec

git add . 
git commit -m "update ${version} code FinAppletWXExt.podspec "
git push origin HEAD:refs/heads/master
echo "❤️❤️❤️❤️ creat FinAppletWXExt code podspec end"

# echo ">>>>🍏🍏🍏🍏>>>>>>>[Release] upgrading FinAppletWXExt github start"
# git clone --depth=1 ssh://git@github.com/finogeeks/FinAppletWXExt.git
# cd FinAppletWXExt

# cp -r ../dist/Release/FinAppletWXExt.framework .
# cp -r FinAppletWXExt.podspec.tpl FinAppletWXExt.podspec
# sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec

# git add .
# git commit -m "version++"
# git tag -d ${version}
# git push origin --delete tag ${version}
# git tag -a ${version} -m 'FinClip agora发版'
# git push origin HEAD:refs/heads/master --tags -f

# cd ..
# rm -rf FinAppletWXExt

# echo ">>>>🍏🍏🍏🍏>>>>>>>[Release] upgrading FinAppletWXExt github end"

#echo "====cocoapods上传需要自动审核=====暂停30分！！！！！====="

#echo $(date "+%Y%m%d-%H%M%S")

#sleep 900

#echo $(date "+%Y%m%d-%H%M%S")

#echo "❤️❤️❤️❤️ upload to cocoapods start"
#cp -r FinAppletWXExt.dist.podspec FinAppletWXExt.podspec
#pod trunk push FinAppletWXExt.podspec --verbose
#echo "❤️❤️❤️❤️ upload to cocoapods end"
