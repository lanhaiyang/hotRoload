#!/usr/bin/env bash
# https://www.jianshu.com/p/77701b87fb48

filePath=$1
fileName=$2
simulator=$3
phoneIp=$4
importHeadPath=$5
seletCer=$6
baseFilePath=$7

echo "\n===========1=========\n"
echo "接收到的变量:\n"
echo ${filePath}
echo ${fileName}
echo ${simulator}
echo ${phoneIp}
echo ${importHeadPath}
echo ${seletCer}
echo ${baseFilePath}
echo "\n====================\n"

#baseFilePath="/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/DWHotReload-master/shell"
tempFilePath=${baseFilePath}"/archiveFile"
dylibFilePath=${baseFilePath}"/dylibs"

# 将改动后的.m文件编译成 .o文件
#linkTarget="x86_64-apple-ios10.0-simulator"
linkTarget="arm64-apple-ios11.0-simulator"

#linkIsysroot="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator14.0.sdk"
# 模拟器
linkIsysroot="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk"

#objectCahcePath="/Users/dingwei/Library/Developer/Xcode/DerivedData/DWDebugHR-fahgfhvqgkwjbgdxifevhwtdnpmp/Build/Intermediates.noindex/DWDebugHR.build/Debug-iphonesimulator/DWDebugHR.build/DWDebugHR-project-headers.hmap"
objectCahcePath="/Users/lanhaiyang/Library/Developer/Xcode/DerivedData/TestHotRoload-edneskslwtlxvtbmwtbmilpdpiwn/Build/Intermediates.noindex/TestHotRoload.build/Debug-iphonesimulator/TestHotRoload.build/TestHotRoload-all-target-headers.hmap"


##判断是否是真机
if [ ${simulator} == "phone" ];then
#linkTarget="arm64-apple-ios12.0"
linkTarget="arm64-apple-ios11.0"

#linkIsysroot="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS14.0.sdk "
#linkIsysroot="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneSimulator.sdk"
# 真机
linkIsysroot="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk"
fi

#echo "\n============2========\n"
### 将 .m 编译成 .o文件
#echo "clang -x objective-c -target ${linkTarget} -fobjc-arc -fmodules  -isysroot ${linkIsysroot} -iquote ${objectCahcePath} -c ${filePath} -o ${tempFilePath}/${fileName}.o"
#echo "\n====================\n"

# clang -x objective-c -arch arm64 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -iquote  -I/Users/lanhaiyang/Library/Developer/Xcode/DerivedData/TestHotRoload-edneskslwtlxvtbmwtbmilpdpiwn/Build/Intermediates.noindex/TestHotRoload.build/Debug-iphonesimulator/TestHotRoload.build/TestHotRoload-all-target-headers.hmap -I/Users/lanhaiyang/Library/Developer/Xcode/DerivedData/TestHotRoload-edneskslwtlxvtbmwtbmilpdpiwn/Build/Intermediates.noindex/TestHotRoload.build/Debug-iphonesimulator/TestHotRoload.build/TestHotRoload-own-target-headers.hmap  -I/Users/lanhaiyang/Library/Developer/Xcode/DerivedData/TestHotRoload-edneskslwtlxvtbmwtbmilpdpiwn/Build/Intermediates.noindex/TestHotRoload.build/Debug-iphonesimulator/TestHotRoload.build/TestHotRoload-generated-files.hmap -I/Users/lanhaiyang/Library/Developer/Xcode/DerivedData/TestHotRoload-edneskslwtlxvtbmwtbmilpdpiwn/Build/Intermediates.noindex/TestHotRoload.build/Debug-iphonesimulator/TestHotRoload.build/TestHotRoload-own-target-headers.hmap -I/Users/lanhaiyang/Library/Developer/Xcode/DerivedData/TestHotRoload-edneskslwtlxvtbmwtbmilpdpiwn/Build/Intermediates.noindex/TestHotRoload.build/Debug-iphonesimulator/TestHotRoload.build/TestHotRoload-all-non-framework-target-headers.hmap -I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/TestHotRoload/Category -c /Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/TestHotRoload/DWViewController.m -o /Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/DWHotReload-master/shell/archiveFile/DWViewController.o

# clang -rewrite-objc -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -iquote  -I/Users/lanhaiyang/Library/Developer/Xcode/DerivedData/TestHotRoload-edneskslwtlxvtbmwtbmilpdpiwn/Build/Intermediates.noindex/TestHotRoload.build/Debug-iphonesimulator/TestHotRoload.build/TestHotRoload-all-target-headers.hmap -I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/TestHotRoload/Category -c /Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/TestHotRoload/DWViewController.m -o /Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/DWHotReload-master/shell/archiveFile/DWViewController.o

#clang -x objective-c -target ${linkTarget} -fobjc-arc -fmodules  -isysroot ${linkIsysroot} -iquote ${objectCahcePath} -I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/TestHotRoload/Category -c ${filePath} -o ${tempFilePath}/${fileName}.o

#clang -x objective-c -target ${linkTarget} -fobjc-arc -fmodules  -isysroot ${linkIsysroot} -iquote ${objectCahcePath} -I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/TestHotRoload/Category -I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/Masonry/Masonry -c ${filePath} -o ${tempFilePath}/${fileName}.o
#freshLinkPath="${linkPath//-I/ -I}"

#echo "clang -x objective-c -target ${linkTarget} -fobjc-arc -fmodules  -isysroot ${linkIsysroot} -iquote ${objectCahcePath} ${freshLinkPath} -c "${filePath}" -o ${tempFilePath}/${fileName}.o"

echo "clang -x objective-c -target ${linkTarget} -fobjc-arc -fmodules -isysroot ${linkIsysroot} -iquote ${objectCahcePath} ${freshLinkPath} -c ${filePath} -o ${tempFilePath}/${fileName}.o"

freshLinkPath="$(less $importHeadPath)"

echo $freshLinkPath



command || { echo "command failed"; exit 1; }

#clang -x objective-c -target ${linkTarget} -fobjc-arc -fmodules  -isysroot ${linkIsysroot} -iquote ${objectCahcePath} ${freshLinkPath} -c ${filePath} -o ${tempFilePath}/${fileName}.o

clang -x objective-c -target ${linkTarget} -fobjc-arc -fmodules -isysroot ${linkIsysroot} -iquote ${objectCahcePath} ${freshLinkPath} -c "${filePath}" -o ${tempFilePath}/${fileName}.o


command || { echo "command failed"; exit 1; }

# 创建linkFileList文件
dirAndName="$baseFilePath/DWHR.LinkFileList"
if [ ! -d "$baseFilePath" ];then
echo "父级文件夹路径错误"
else
cd $baseFilePath
    # 文件不存在
if [ ! -f "$dirAndName" ];then
echo "文件不存在";
cat>$dirAndName<<EOF
${tempFilePath}/${fileName}.o
EOF
# 文件存在 先删除
else
echo "文件存在";
rm -f $dirAndName
cat>$dirAndName<<EOF
${tempFilePath}/${fileName}.o
EOF
fi
fi

# 链接成一个动态库
ctime=$(date "+%Y%m%d%H%M%S")

echo "\n==========3==========\n"
echo "clang -x objective-c -target ${linkTarget} -dynamiclib -isysroot ${linkIsysroot} -filelist $dirAndName   -Xlinker -objc_abi_version -Xlinker 2 -fobjc-link-runtime -Xlinker -sectcreate -Xlinker __TEXT -Xlinker __entitlements  -Xlinker ${tempFilePath}/${fileName}.o -o ${dylibFilePath}/dw${ctime}.dylib"
echo "\n====================\n"

clang -x objective-c -target ${linkTarget} -dynamiclib -isysroot ${linkIsysroot} -filelist $dirAndName -Xlinker -objc_abi_version -Xlinker 2 -fobjc-link-runtime -Xlinker -sectcreate -Xlinker __TEXT -Xlinker __entitlements  -Xlinker ${tempFilePath}/${fileName}.o -o ${dylibFilePath}/dw${ctime}.dylib

command || { echo "command failed"; exit 1; }

# 真机动态库需要进行签名，否则无法dlopen加载成功
# codesign -f -s 'iPhone Developer: xxx zhuo (MQF8D9PK85)'  xxx.app
# security find-identity -v -p codesigning # 查看证书
# Apple Development: 1002230810@qq.com (T9M6DU9A39)
if [ ${simulator} == "phone" ];then
#codesign -f -s "证书" ${dylibFilePath}/dw${ctime}.dylib

codesign -f -s "${seletCer}" ${dylibFilePath}/dw${ctime}.dylib

echo "codesign -f -s ${seletCer} ${dylibFilePath}/dw${ctime}.dylib"
fi

# 将dylib上传给开启的app

## 如果是模拟器默认获取本机ip
ip=$(/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:")

## 真机的话ip需要获取外部指定的手机ip地址
if [ ${simulator} == "phone" ];then
ip=$4
fi

dylibPath='/'${dylibFilePath}'/dw'${ctime}'.dylib'
curl -H "Expect:" -F "file=@"${dylibPath} http://${ip}:8080/upload

#上传成功后将dylib 删除掉
rm -r ${dylibPath}
