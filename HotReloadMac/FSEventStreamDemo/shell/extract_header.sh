
for i in "find . -name \"*.h\"";
do path=$(dirname $i);
	 echo "i = "  $i			 
	 echo "dirname = "  $(dirname $i)
	 echo "path = "  $path
	 # mkdir -p absl-bak/include/$path;
	 # cp $i absl-bak/include/$path;
done

#
#
## 当前项目名字，需要修改！
#PROJECT_NAME='ABC'
#
## 编译工程
#BINARY_NAME="${PROJECT_NAME}Binary"
#
#cd Example
#
#INSTALL_DIR=$PWD/../Pod/Products
#rm -fr "${INSTALL_DIR}"
#mkdir $INSTALL_DIR
#WRK_DIR=build
#
#BUILD_PATH=${WRK_DIR}
#
#DEVICE_INCLUDE_DIR=${BUILD_PATH}/Release-iphoneos/usr/local/include #获得项目编译目录 要放在获取项目上
#DEVICE_DIR=${BUILD_PATH}/Release-iphoneos/lib${BINARY_NAME}.a
#SIMULATOR_DIR=${BUILD_PATH}/Release-iphonesimulator/lib${BINARY_NAME}.a
#RE_OS="Release-iphoneos"
#RE_SIMULATOR="Release-iphonesimulator"
#
#xcodebuild -configuration "Release" -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${BINARY_NAME}" -sdk iphoneos clean build CONFIGURATION_BUILD_DIR="${WRK_DIR}/${RE_OS}" LIBRARY_SEARCH_PATHS="./Pods/build/${RE_OS}"
#xcodebuild ARCHS=x86_64 ONLY_ACTIVE_ARCH=NO -configuration "Release" -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${BINARY_NAME}" -sdk iphonesimulator clean build CONFIGURATION_BUILD_DIR="${WRK_DIR}/${RE_SIMULATOR}" LIBRARY_SEARCH_PATHS="./Pods/build/${RE_SIMULATOR}"
#
#if [ -d "${INSTALL_DIR}" ]
#then
#rm -rf "${INSTALL_DIR}"
#fi
#mkdir -p "${INSTALL_DIR}"
#
#cp -rp "${DEVICE_INCLUDE_DIR}" "${INSTALL_DIR}/"
#
#INSTALL_LIB_DIR=${INSTALL_DIR}/lib
#mkdir -p "${INSTALL_LIB_DIR}"
#
#lipo -create "${DEVICE_DIR}" "${SIMULATOR_DIR}" -output "${INSTALL_LIB_DIR}/lib${PROJECT_NAME}.a"
#rm -r "${WRK_DIR}"
