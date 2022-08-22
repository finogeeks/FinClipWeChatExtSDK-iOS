#!/bin/bash
# 这个脚本是为了将核心SDK和其他拓展SDK压缩到一起，并上传到官网https://finclip-testing.finogeeks.club/downloads/

version=$1

cd dist

#删除并新建文件夹
rm -rf FinIOSSDKzip-${version}

rm FinIOSSDKzip-${version}.zip

mkdir  FinIOSSDKzip-${version}

#下载核心和拓展SDK压缩包、解压并重新压缩到一起
curl -o "FinIOSSDKzip-${version}/FinApplet-${version}.zip"  "https://app.finogeeks.com/finchat/sdk/FinApplet-${version}.zip"

curl -o "FinIOSSDKzip-${version}/FinAppletExt-${version}.zip"  "https://app.finogeeks.com/finchat/sdk/FinAppletExt-${version}.zip"

curl -o "FinIOSSDKzip-${version}/FinAppletBDMap-${version}.zip"  "https://app.finogeeks.com/finchat/sdk/FinAppletBDMap-${version}.zip"

curl -o "FinIOSSDKzip-${version}/FinAppletGDMap-${version}.zip"  "https://app.finogeeks.com/finchat/sdk/FinAppletGDMap-${version}.zip"

curl -o "FinIOSSDKzip-${version}/FinAppletWebRTC-${version}.zip"  "https://app.finogeeks.com/finchat/sdk/FinAppletWebRTC-${version}.zip"

curl -o "FinIOSSDKzip-${version}/FinAppletAgoraRTC-${version}.zip"  "https://app.finogeeks.com/finchat/sdk/FinAppletAgoraRTC-${version}.zip"

curl -o "FinIOSSDKzip-${version}/FinAppletContact-${version}.zip"  "https://app.finogeeks.com/finchat/sdk/FinAppletContact-${version}.zip"

curl -o "FinIOSSDKzip-${version}/FinAppletWXExt-${version}.zip"  "https://app.finogeeks.com/finchat/sdk/FinAppletWXExt-${version}.zip"


unzip "FinIOSSDKzip-${version}/FinApplet-${version}.zip" -d FinIOSSDKzip-${version}

unzip "FinIOSSDKzip-${version}/FinAppletExt-${version}.zip" -d FinIOSSDKzip-${version}

unzip "FinIOSSDKzip-${version}/FinAppletBDMap-${version}.zip" -d FinIOSSDKzip-${version}

unzip "FinIOSSDKzip-${version}/FinAppletGDMap-${version}.zip" -d FinIOSSDKzip-${version}

unzip "FinIOSSDKzip-${version}/FinAppletWebRTC-${version}.zip" -d FinIOSSDKzip-${version}

unzip "FinIOSSDKzip-${version}/FinAppletAgoraRTC-${version}.zip" -d FinIOSSDKzip-${version}

unzip "FinIOSSDKzip-${version}/FinAppletContact-${version}.zip" -d FinIOSSDKzip-${version}

unzip "FinIOSSDKzip-${version}/FinAppletWXExt-${version}.zip" -d FinIOSSDKzip-${version}


rm "FinIOSSDKzip-${version}/FinApplet-${version}.zip"

rm "FinIOSSDKzip-${version}/FinAppletExt-${version}.zip"

rm "FinIOSSDKzip-${version}/FinAppletBDMap-${version}.zip"

rm "FinIOSSDKzip-${version}/FinAppletGDMap-${version}.zip"

rm "FinIOSSDKzip-${version}/FinAppletWebRTC-${version}.zip"

rm "FinIOSSDKzip-${version}/FinAppletAgoraRTC-${version}.zip"

rm "FinIOSSDKzip-${version}/FinAppletContact-${version}.zip"

rm "FinIOSSDKzip-${version}/FinAppletWXExt-${version}.zip"



zip -r FinIOSSDKzip-${version}.zip FinIOSSDKzip-${version}

# #上传,120秒超时
# expect -c "
# set timeout 120;
# spawn scp -r FinIOSSDKzip-${version}.zip finchat@106.52.4.150:/mnt/data/ci/app/html/finchat/sdk
# expect "*assword*" { send "abcd@@123"\n }
# expect eof
# "

#上传到cdn
curl --request POST \
        --url https://finogeeks-tools.finogeeks.club/test-report/upload \
        --header 'cache-control: no-cache' \
        --form "file=@FinIOSSDKzip-${version}.zip" \
        --form 'namespace=sdk' \
        --form 'cdn=true' \
        --form 'token=finclip@static' -s
