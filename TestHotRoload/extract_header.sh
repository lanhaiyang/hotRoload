linkPath="-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/GCDWebServer/GCDWebServer/Core/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/GCDWebServer/GCDWebServer/Responses/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/GCDWebServer/GCDWebServer/Requests/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/GCDWebServer/GCDWebUploader/GCDWebUploader.bundle/Contents/Resources/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/GCDWebServer/GCDWebUploader/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/Pods.xcodeproj/xcuserdata/lanhaiyang.xcuserdatad/xcschemes/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/Target Support Files/GCDWebServer/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/Target Support Files/Pods-TestHotRoload/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/Target Support Files/Masonry/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/Masonry/Masonry/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/Headers/Public/GCDWebServer/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/Headers/Public/Masonry/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/Headers/Private/GCDWebServer/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/Pods/Headers/Private/Masonry/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/TestHotRoload/ClassSwizzle/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/TestHotRoload/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/TestHotRoload/Category/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/TestHotRoload/DWHotReload/-I/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload/TestHotRoload/FileChange/"
new_path="${linkPath//-I/ -I}"  
echo $new_path

# 原始路径字符串  
path="-I/xxx/xxx/-I/xxxx/xxx/-I/xxxx/xxxx"  
  
# 使用字符串替换功能添加空格  
# 注意：这里的//表示全局替换，即替换所有出现的-I  
new_path="${path//-I/ -I}"  
  
# 输出替换后的结果  
echo "$new_path"