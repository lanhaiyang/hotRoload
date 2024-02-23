//
//  FileManager.h
//  FSEventStreamDemo
//
//  Created by 何鹏 on 2024/2/13.
//  Copyright © 2024 yww. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileManager : NSObject


-(NSArray<NSString *> *)searchFiles:(NSString *)path fileType:(NSArray<NSString *> *)fileType;

- (NSString *)writeToTXTFileWithString:(NSString *)string fileName:(NSString *)fileName;


+(NSString *)getForPath;


+(void)creatFile;

@end

NS_ASSUME_NONNULL_END
