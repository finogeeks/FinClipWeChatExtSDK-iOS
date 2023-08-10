#!/bin/bash -l

export LANG=en_US.UTF-8
export FASTLANE_DISABLE_COLORS=1
export version="$1"
export branch="$2"
export createReport=false
export isStatic="$3"
export isdeploy="$4"
export isUploadFramework="$5"

echo ">>>>>>>>>>> version: ${version}"
echo ">>>>>>>>>>> branch: ${branch}"
echo ">>>>>>>>>>> isStatic: ${isStatic}"
echo ">>>>>>>>>>> isdeploy: ${isdeploy}"
echo ">>>>>>>>>>> isUploadFramework: ${isUploadFramework}"

cp -r Podfile.dev.tpl Podfile
sed -i "" "s/__finapplet_version__/${version}/g" Podfile

cp FATWXExtPrivateContant.tpl FinAppletWXExt/FATWXExtPrivateContant.h
sed -i "" "s/_FinApplet_version_/${version}/g" FinAppletWXExt/FATWXExtPrivateContant.h

rm -rf build dist

bundle install
pod update

echo "打包动态库>>>>>>"

if [[ "$isdeploy" == true ]]
then
    echo "打deploy版本的包>>>>>>"
    fastlane deploy
#    curl -F "binfile=@dist/FinClipWeChatExtSDK-Min-${version}.zip" -F "dir=finclip/ios/all" "http://192.168.0.35:4003/upload"
#    curl -F "binfile=@dist/FinClipWeChatExtSDK-${version}.zip" -F "dir=finclip/ios/all" "http://192.168.0.35:4003/upload"
    # 开始打Release版小程序SDK
    cp -r FinAppletWXExt.tpl.podspec FinAppletWXExt.podspec
    cp -r FinAppletWXExt-Min.tpl.podspec FinAppletWXExt-Min.podspec

    sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec
    sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt-Min.podspec
    # 内存拷贝进FinApplet.dist.podspec 便于查看打出的framework
    cp -f FinAppletWXExt.podspec FinAppletWXExt.dist.podspec

    #pod repo push finclip FinAppletWXExt.podspec --skip-import-validation --skip-tests --allow-warnings
    cp -f FinAppletWXExt.podspec  ../ext_podspec/FinAppletWXExt.podspec

    git remote add ssh-origin ssh://git@gitlab.finogeeks.club:2233/finclipsdk/finclipwechatextsdk-ios.git

    echo "❤️❤️❤️❤️ creat FinAppletWXExt code podspec start"
    cp -r FinAppletWXExt.code.tpl.podspec FinAppletWXExt.podspec
    sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec
    git add .
    git commit -m "update ${version} code FinAppletWXExt.podspec"
    git push ssh-origin HEAD:refs/heads/master
    echo "❤️❤️❤️❤️ creat FinAppletWXExt code podspec end"
    
    echo "❤️❤️❤️❤️ creat tag and push"
    git tag -d ${version}
    git push ssh-origin --delete tag ${version}
    git tag -a ${version} -m 'deploy new version'
    git push ssh-origin --tags -f

else
    echo "打develop版本的包>>>>>>"
    
    echo "编译并生成动态库>>>>>>"
    
    fastlane dev createReport:$createReport
    cp -r FinAppletWXExt.dev.tpl.podspec FinAppletWXExt.podspec
    
    echo "上传>>>>>>"
#    curl -F "binfile=@dist/FinClipWeChatExtSDK-dev-${version}.zip" -F "dir=finclip/ios/all" "http://192.168.0.35:4003/upload"

    # 开始打Release版小程序SDK
    sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec
    echo "准备发布>>>>>>"

    # 内存拷贝进FinAppletWXExt.dist.podspec 便于查看打出的framework
    cp -f FinAppletWXExt.podspec FinAppletWXExt.dist.podspec
    echo "内存拷贝进FinAppletWXExt.dist.podspec>>>>>>"
    
    #pod repo push finclip-dev FinAppletWXExt.podspec --skip-tests --allow-warnings --skip-import-validation
    cp -f FinAppletWXExt.podspec  ../ext_podspec/FinAppletWXExt.podspec

    # 生成源码依赖的podspec
    echo "❤️❤️❤️❤️ creat FinAppletWXExt code podspec"
    
    cp -r FinAppletWXExt.code.tpl.podspec FinAppletWXExt.podspec
    sed -i "" "s/_FinAppletWXExt_version_/${version}/g" FinAppletWXExt.podspec
    commitbranch=`echo "${branch}" | sed "s/origin\///g"`
    
    echo $commitbranch

    git remote add ssh-origin ssh://git@gitlab.finogeeks.club:2233/finclipsdk/finclipwechatextsdk-ios.git
    echo "远端仓库地址更新。"
    git add .
    git commit -m "update ${version} code FinAppletWXExt.podspec "
    git push ssh-origin HEAD:refs/heads/${commitbranch}
    git tag -d ${version}
    git push ssh-origin --delete tag ${version}
    git tag -a ${version} -m 'deploy new version'
    git push ssh-origin --tags -f
fi


