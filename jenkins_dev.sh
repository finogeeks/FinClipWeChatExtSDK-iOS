#!/bin/bash -l


export LANG=en_US.UTF-8

export FASTLANE_DISABLE_COLORS=1




#version=`git tag -l --sort=committerdate  |awk 'END {print}' | tr -d '\\n' | tr -d '\\t'`

#version=`git describe --abbrev=0 --tags | tr -d '\\n' | tr -d '\\t'`

echo ">>>>>>>>>>> 当前版本: ${version}"
echo ">>>>>>>>>>> 当前分支: ${branch}"
echo ">>>>>>>>>>> 是否uploadToGit: ${uploadToGit}"
echo ">>>>>>>>>>> 是否生成静态分析报告: ${createReport}"


security unlock-keychain -p Ftjk@@v587 ~/Library/Keychains/login.keychain


git reset --hard

git checkout ${branch}

bundle install --path vendor/cache

cp -r Podfile.dev.tpl Podfile
sed -i "" "s/__finapplet_version__/${version}/g" Podfile
#sed -i "s/pod 'FinApplet'/pod 'FinApplet', '${version}'/g" Podfile

pod update

rm -rf build dist

if [[ "$createReport" == true ]]
then
	echo "编译并生成静态分析报告>>>>>>"
	sh oclint.sh ${version}
else 
	echo "⁉️⁉️ 跳过静态分析报告环节>>>>>>"
fi

fastlane dev createReport:$createReport



# 开始打Release版小程序SDK
cp -r FinAppletWXExt.dev.tpl.podspec FinAppletWXExt.podspec

# 替换版本号
sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec

# 拷贝进FinAppletWXExt.dist.podspec 便于查看打出的framework
cp -f FinAppletWXExt.podspec FinAppletWXExt.dist.podspec


echo ">>>>>>>>>>>[Release] start upgrading FinPods"
git clone ssh://git.finogeeks.club/finoapp-ios/DevPods

rm -rf DevPods/FinAppletWXExt/${version}

mkdir -p DevPods/FinAppletWXExt/${version}
cp FinAppletWXExt.podspec DevPods/FinAppletWXExt/${version}/FinAppletWXExt.podspec
cd DevPods

git add FinAppletWXExt/${version} && git commit -m "upgrade FinAppletWXExt ${version}" && git push

cd ..

rm -rf DevPods

if [[ "$uploadToGit" == true ]]
then
	echo "准备上传至官网的git"
	./uploadToCom.sh ${version} 1
fi

# 生成源码依赖的podspec
echo "❤️❤️❤️❤️ creat FinAppletWXExt code podspec"

cp -r FinAppletWXExt.code.tpl.podspec FinAppletWXExt.podspec

sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec

commitbranch=`echo "${branch}" | sed "s/origin\///g"`

git add . 
git commit -m "update ${version} code FinAppletWXExt.podspec "
git push origin HEAD:refs/heads/${commitbranch}
