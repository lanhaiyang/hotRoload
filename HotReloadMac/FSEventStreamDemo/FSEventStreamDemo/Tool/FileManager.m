//
//  FileManager.m
//  FSEventStreamDemo
//
//  Created by 何鹏 on 2024/2/13.
//  Copyright © 2024 yww. All rights reserved.
//

#import "FileManager.h"


@interface FileManager ()

@property (nonatomic, strong) NSMutableArray<NSString *> *pathListMs;

@end

@implementation FileManager

-(instancetype)init{
    if([super init]){
        _pathListMs = [NSMutableArray array];
    }
    return self;
}



- (void)showFiles:(NSString *)path fileType:(NSArray<NSString *> *)fileType isNeedFileName:(BOOL)isNeedFileName{

    // 1.判断文件还是目录

    NSFileManager * fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        // 2. 判断是不是目录
        if (isDir) {
            NSArray * dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
            NSString * subPath = nil;
            for (NSString * str in dirArray) {
                subPath  = [path stringByAppendingPathComponent:str];
                if([self judgFileTypeWithFileTypes:fileType path:subPath]){
                    
                    BOOL issubDir = NO;
                     [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
                    if(isNeedFileName == YES){
                        [self addArrayWithPath:subPath];
                    }else{
                        [self addArrayWithPath:path];
                    }
                }
                [self showFiles:subPath fileType:fileType isNeedFileName:isNeedFileName];
            }
        }else{
//            NSLog(@"%@",path);
        }

    }else{
//        NSLog(@"你打印的是目录或者不存在");
    }

}



+(void)creatFile{
    
    
    NSFileManager *manager = [NSFileManager defaultManager];

    NSString *archiveFile = [NSString stringWithFormat:@"%@/archiveFile",[self getForPath]];
    NSURL *archiveFileUrl = [NSURL fileURLWithPath:archiveFile
                            isDirectory:YES];
    NSLog(@"basePath = %@",[self getForPath]);

    if([manager fileExistsAtPath:archiveFile] == NO){
        NSError *createError = nil;
        BOOL success = [manager createDirectoryAtURL:archiveFileUrl
                         withIntermediateDirectories:YES
                                          attributes:nil
                                               error:&createError];
    }

    
    NSString *dylibs = [NSString stringWithFormat:@"%@/dylibs",[self getForPath]];
    
    
    NSURL *dylibsUrl = [NSURL fileURLWithPath:dylibs
                                  isDirectory:YES];
    
    if([manager fileExistsAtPath:dylibs] == NO){
        NSError *createError = nil;
        BOOL success = [manager createDirectoryAtURL:dylibsUrl
                         withIntermediateDirectories:YES
                                          attributes:nil
                                               error:&createError];
    }
    
    
    NSString *theFilePath = [[self getForPath] stringByAppendingPathComponent:@"DWHR.LinkFileList"];
    //如果文件不存在 创建文件
    if([manager fileExistsAtPath:theFilePath]){
        [manager removeItemAtPath:theFilePath error:nil];
    }
    
    if(![manager fileExistsAtPath:theFilePath]){
        NSString *bitPath = [NSString stringWithFormat:@"%@/archiveFile"];
        NSArray *list = [[FileManager new] searchFiles:bitPath fileType:@[@"o"] isNeedFileName:YES];
        if(list.count != 0){
            NSString *content = [list componentsJoinedByString:@"\n"];
            content = [NSString stringWithFormat:@"%@\n",content];
            [content writeToFile:theFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }else{
            [@"" writeToFile:theFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        
    }
}



+(NSString *)getForPath{
    NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [NSString stringWithFormat:@"%@/HotUpdate",[paths objectAtIndex:0]];
    return path;
}

- (NSString *)writeToTXTFileWithString:(NSString *)string fileName:(NSString *)fileName {
    //获取沙盒路径
    NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //获取文件路径
    NSString *fullName = [NSString stringWithFormat:@"%@.txt", fileName];
    NSString *theFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fullName];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized (self) {

            //创建文件管理器
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //如果文件不存在 创建文件
            if([fileManager fileExistsAtPath:theFilePath]){
                [fileManager removeItemAtPath:theFilePath error:nil];
                
            }
            if(![fileManager fileExistsAtPath:theFilePath]){
                [@"" writeToFile:theFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:theFilePath];
            [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
            NSData* stringData  = [[NSString stringWithFormat:@"%@\n",string] dataUsingEncoding:NSUTF8StringEncoding];
            [fileHandle writeData:stringData]; //追加写入数据
            [fileHandle closeFile];
        }
    });
    return theFilePath;
}

-(void)addArrayWithPath:(NSString *)path{
    
    BOOL isExit = NO;
//    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
//    if([path containsString:@" "]){
//        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
////        return;
//    }
    for(NSString *listPath in _pathListMs){
        if([listPath isEqualToString:path]){
            isExit = YES;
            break;
        }
    }
    
    if(isExit == NO){
        [_pathListMs addObject:path];
    }
    
    NSString *addPath = @"";
    if([path containsString:@"Pods/"]){
        NSArray *paths = [path componentsSeparatedByString:@"/"];
        
        for(int i = 1; i < paths.count - 1;i ++){
            NSString *url = paths[i];
            if(url.length != 0){
                addPath = [NSString stringWithFormat:@"%@/%@",addPath,url];
            }
        }
//        NSLog(@"addPath = %@",addPath);
    }
    
    if(addPath.length == 0){
        return;
    }
    
    for(NSString *listPath in _pathListMs){
        if([listPath isEqualToString:addPath]){
            isExit = YES;
            break;
        }
    }
    
    if(isExit == NO){
        [_pathListMs addObject:addPath];
    }
}

-(BOOL)judgFileTypeWithFileTypes:(NSArray<NSString *> *)fileTypes path:(NSString *)path{
    
    for(NSString * fileType in fileTypes){
        if([[path pathExtension] containsString:fileType]){
            return YES;
        }
    }
    return NO;
}


-(NSArray<NSString *> *)searchFiles:(NSString *)path fileType:(NSArray<NSString *> *)fileType isNeedFileName:(BOOL)isNeedFileName{
    
    [_pathListMs removeAllObjects];
    [self showFiles:path fileType:fileType isNeedFileName:isNeedFileName];
    return _pathListMs.copy;
}

@end
