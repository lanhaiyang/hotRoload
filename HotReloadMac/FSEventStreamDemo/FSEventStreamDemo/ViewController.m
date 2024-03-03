//
//  ViewController.m
//  FSEventStreamDemo
//
//  Created by 曾文斌 on 2017/7/26.
//  Copyright © 2017年 yww. All rights reserved.
//

#import "ViewController.h"
#import "HTTaskManager.h"
#import <CoreServices/CoreServices.h>
#import "FileManager.h"

void fsevents_callback(ConstFSEventStreamRef streamRef,
                       void *userData,
                       size_t numEvents,
                       void *eventPaths,
                       const FSEventStreamEventFlags eventFlags[],
                       const FSEventStreamEventId eventIds[]);

@interface ViewController()

@property(nonatomic) NSInteger syncEventID;

//使用 FSEventStream 监控 Mac 文件变化
@property(nonatomic, assign) FSEventStreamRef syncEventStream;

@property (weak) IBOutlet NSTextField *showPath;


@property (weak) IBOutlet NSButton *seletPath;

@property (weak) IBOutlet NSComboBox *seletCer;

@property (weak) IBOutlet NSTextField *input;

@property (weak) IBOutlet NSButton *isPhone;

@property (nonatomic, strong) NSString *projectPath;
@property (nonatomic, strong) FileManager *file;
@property (nonatomic, strong) NSArray<NSString *> *cerLists;
//@property (nonatomic, strong) NSString *selectedCerPath;
@property (nonatomic, strong) NSString *selectedCerContent;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) NSString *importPath;
//@property (nonatomic, strong) NSString *seletFilePaht;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
    [self confige];
}


-(void)setView{
    
    [_seletCer setAction:@selector(selectionChaned:)];
}

- (void)selectionChaned:(id)sender {
    
    NSComboBox *comboBox = sender;
    
    NSInteger selectedIndex = comboBox.indexOfSelectedItem;
    
    NSString *selectedContent = comboBox.stringValue;
    _selectedCerContent = selectedContent;
//    _selectedCerPath = [self.file writeToTXTFileWithString:selectedContent fileName:@"cer"];
    NSLog(@"selectedContent %@ at index %ld",selectedContent,selectedIndex);
}

- (IBAction)seletFile:(id)sender {
    
   NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.prompt = @"选择";
//    openPanel.canchooseDirectories = false;//不允许选择目录
//    openPanel.canChooseFiles = true; //选择文件
    openPanel.canChooseDirectories = true; //
    openPanel.allowsMultipleSelection = true;
    openPanel.canChooseFiles = false;
    BOOL okButtonPressed = ([openPanel runModal] == NSModalResponseOK);
    //[openPanel runModal]此时线程会停在这里等待选择
    //NO表示用户取消 YES表示用户做出选择
    if(okButtonPressed) {
        NSString *path = [[openPanel URL] path];
        _projectPath = path;
        _showPath.placeholderString = _projectPath;
        [self updateSearch];
    }
//    [openPanel beginSheet:self.view.window completionHandler:^(NSModalResponse returnCode) {
//
//        if(returnCode != 0){
//            return;
//        }
//
//        //遍历路径（多选情况下）
//        for(NSURL *url in openPanel.URLs){
//            _projectPath = url.path;
//            break;
//        }
//    }];
    
}

- (IBAction)seletIsPhone:(NSButton *)sender {
    _seletCer.enabled = sender.state;
}


-(void)confige{
//    _projectPath = @"/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/TestHotRoload";
    _projectPath = @"";
    _file = [[FileManager alloc] init];
    _isOpen = NO;
    [self getForCertificate];
    [FileManager creatFile];
}


-(void)getForCertificate{
    
    [[HTTaskManager sharedManager] execShellCMDWith:@"security find-identity -v -p codesigning" completeBlock:^(NSString *resultStr, NSString *errorStr) {
        NSLog(@"shell resultStr: %@",resultStr);
        printf("\n");
//        NSLog(@"error: %@",errorStr);
        
        NSArray<NSString *> *list = [self getRegularExpressionWithContent:resultStr Pattern:@"\"(.*?)\""];
        NSMutableDictionary *infoMs = [NSMutableDictionary dictionary];
        for(NSString *content in list){
            [infoMs setObject:content forKey:content];
        }
        list = infoMs.allKeys;
        NSLog(@"list = %@",list);
        self.cerLists = list;
        [self.seletCer removeAllItems];
        self.seletCer.numberOfVisibleItems = self.cerLists.count;
        [self.seletCer addItemsWithObjectValues:self.cerLists];
    }];
}


-(NSArray<NSString *> *)getRegularExpressionWithContent:(NSString *)content Pattern:(NSString *)pattern{
    
    NSString *inputString = content;
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    if (error) {
        NSLog(@"Error occurred while creating regular expression: %@", error);
        return @[];
    }
    
    NSArray *matches = [regex matchesInString:inputString options:0 range:NSMakeRange(0, [inputString length])];
    NSMutableArray *searchContentMs = [NSMutableArray array];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match rangeAtIndex:1];
        NSString *extractedString = [inputString substringWithRange:matchRange];
//        NSLog(@"Extracted string: %@", extractedString);
        [searchContentMs addObject:extractedString];
    }

    return searchContentMs.copy;
}


-(void)updateSearch{
    NSArray *list = [_file searchFiles:_projectPath fileType:@[@"h"] isNeedFileName:NO];
    NSString *linkPaht = @"";
    for(NSString *path in list){
        if([path containsString:@" "]){
            continue;
        }
        NSString *link = [NSString stringWithFormat:@"-I%@",path];
//        link = [link stringByReplacingOccurrencesOfString:@" " withString:@"\\ "];

        if(linkPaht.length == 0){
            linkPaht = [NSString stringWithFormat:@"%@ ",link];
        }else{
            linkPaht = [NSString stringWithFormat:@"%@%@ ",linkPaht,link];
        }
//        link = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSData *data =[link dataUsingEncoding:NSUTF8StringEncoding];
//        link = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSURL *url = [NSURL URLWithString:link];
//        printf("path = %s \n",link.UTF8String);
    }
    _linkPahts = linkPaht;
    _importPath = [self.file writeToTXTFileWithString:_linkPahts fileName:@"importHead"];
//    NSLog(@"linkPahts = %@",linkPaht);
}



#pragma mark - event

- (IBAction)startWatchClicked:(id)sender {
    
    if(_projectPath.length == 0){
        return;
    }
    
    if(_isOpen == YES){
        return;
    }
    _isOpen = YES;
    if(self.syncEventStream) {
        //停止文件监控
        FSEventStreamStop(self.syncEventStream);
        //从 runloop 中移除
        FSEventStreamInvalidate(self.syncEventStream);
        FSEventStreamRelease(self.syncEventStream);
        self.syncEventStream = NULL;
    }
    
//    NSString *patch = [self get_current_app_path];
    
    NSArray *paths = @[_projectPath];// 这里填入需要监控的文件夹
    FSEventStreamContext context;
    context.info = (__bridge void * _Nullable)(self);
    context.version = 0;
    context.retain = NULL;
    context.release = NULL;
    context.copyDescription = NULL;
    //创建一个文件监控句柄, 可以在这个函数中绑定一个函数回调
    self.syncEventStream = FSEventStreamCreate(NULL, &fsevents_callback, &context, (__bridge CFArrayRef _Nonnull)(paths), self.syncEventID, 1, kFSEventStreamCreateFlagFileEvents | kFSEventStreamCreateFlagUseCFTypes);
//    printf("===>> 开启: %s");
    NSLog(@"===>> 开启");
    //加入到一个 runloop 中, 才可以实现文件的监控
    FSEventStreamScheduleWithRunLoop(self.syncEventStream, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
    
    //启动文件监控
    FSEventStreamStart(self.syncEventStream);
    

}
- (IBAction)stopWatchClicked:(id)sender {
    if(_isOpen == NO){
        return;
    }
    _isOpen = NO;
    if(self.syncEventStream) {
        FSEventStreamStop(self.syncEventStream);
        FSEventStreamInvalidate(self.syncEventStream);
        FSEventStreamRelease(self.syncEventStream);
        self.syncEventStream = NULL;
        NSLog(@"===>> 关闭");
    }
}
#pragma mark - private method
-(void)updateEventID {
    self.syncEventID = FSEventStreamGetLatestEventId(self.syncEventStream);
}
#pragma mark - setter
-(void)setSyncEventID:(NSInteger)syncEventID{
    [[NSUserDefaults standardUserDefaults] setInteger:syncEventID forKey:@"SyncEventID"];
}
-(NSInteger)syncEventID {
    NSInteger syncEventID = [[NSUserDefaults standardUserDefaults] integerForKey:@"SyncEventID"];
    if(syncEventID == 0) {
        syncEventID = kFSEventStreamEventIdSinceNow;
    }
    return syncEventID;
}



-(NSString *)get_current_app_path{
    NSString* path = @"";
    NSString* str_app_full_file_name = [[NSBundle mainBundle] bundlePath];
    NSRange range = [str_app_full_file_name rangeOfString:@"/" options:NSBackwardsSearch];
    if (range.location != NSNotFound)
    {
        path = [str_app_full_file_name substringToIndex:range.location];
        path = [path stringByAppendingFormat:@"%@",@"/"];
    }
    return path;
}

@end

// 用于箭头文件改变
void fsevents_callback(ConstFSEventStreamRef streamRef,
                       void *userData,
                       size_t numEvents,
                       void *eventPaths,
                       const FSEventStreamEventFlags eventFlags[],
                       const FSEventStreamEventId eventIds[]) {
    ViewController *self = (__bridge ViewController *)userData;
    NSArray *pathArr = (__bridge NSArray*)eventPaths;
    FSEventStreamEventId lastRenameEventID = 0;
    NSString* lastPath = nil;
    for(int i=0; i<numEvents; i++){
        FSEventStreamEventFlags flag = eventFlags[i];
        if(kFSEventStreamEventFlagItemCreated & flag) {
            NSLog(@"create file: %@", pathArr[i]);
        }
        if(kFSEventStreamEventFlagItemRenamed & flag) {
            FSEventStreamEventId currentEventID = eventIds[i];
            NSString* currentPath = pathArr[i];
            if (currentEventID == lastRenameEventID + 1) {
                // 重命名或者是移动文件
                NSLog(@"mv %@ %@", lastPath, currentPath);
            } else {
                // 其他情况, 例如移动进来一个文件, 移动出去一个文件, 移动文件到回收站, 修改文件
                if ([[NSFileManager defaultManager] fileExistsAtPath:currentPath]) {
                    
                    NSString *isPhone = self.isPhone.state ? @"phone" : @"empty";
                    NSString *phoneIp = [self.input stringValue];
                    if (self.isPhone.state && phoneIp.length == 0) {
                        NSLog(@"真机运行的话请填写ip地址");
                        return;
                    }
                    
                    NSString *fileName = [[[[currentPath componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."] firstObject];
//                    NSString *shellStr = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", @"/Users/lanhaiyang/Desktop/Lear/iOS/hotRoload/DWHotReload-master/shell/run.sh", currentPath, fileName, isPhone, phoneIp,self.linkPahts];
                    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"run" ofType:@"sh"];
                    NSString *seletCer = (self.selectedCerContent == nil?@"empty":self.selectedCerContent);
                    NSString *baseFilePath = ([FileManager getForPath] == nil?@"empty":[FileManager getForPath]);
                    NSString *shellStr = [NSString stringWithFormat:@"\"%@\" \"%@\" \"%@\" \"%@\" \"%@\" \"%@\" \"%@\" \"%@\"", resourcePath, currentPath, fileName, isPhone, phoneIp,self.importPath,seletCer,baseFilePath];
//                    NSLog(@"shellStr = %@",shellStr);
                    if([[currentPath pathExtension] containsString:@"m"] ||
                       [[currentPath pathExtension] containsString:@"mm"]){
                        
                        [[HTTaskManager sharedManager] execShellCMDWith:shellStr completeBlock:^(NSString *resultStr, NSString *errorStr) {
                            NSLog(@"resultStr: %@",resultStr);
                            printf("\n");
                            NSLog(@"error: %@",errorStr);
                        }];
                        NSLog(@"shell: %@",shellStr);
                        // 移动进来一个文件
                        NSLog(@"move in file: %@", currentPath);
                    }

                    break;
                } else {
                    // 移出一个文件
                    NSLog(@"move out file: %@", currentPath);
                }
            }
            lastRenameEventID = currentEventID;
            lastPath = currentPath;
        }
        if(kFSEventStreamEventFlagItemRemoved & flag) {
            NSLog(@"remove: %@", pathArr[i]);
        }
        if(kFSEventStreamEventFlagItemModified & flag) {
            NSLog(@"modify: %@", pathArr[i]);
        }
    }
    [self updateEventID];
}
