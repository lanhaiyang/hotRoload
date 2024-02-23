//
//  AppDelegate.m
//  TestHotRoload
//
//  Created by 何鹏 on 2024/1/20.
//

#import "AppDelegate.h"
#import "DWServerUploaderManager.h"
#import "DWViewController.h"
//#import "TestHotRoload-Swift.h"
@interface AppDelegate ()

@property (nonatomic, strong) DWViewController *mainVC;

@end

@implementation AppDelegate

+(void)load{
    [serverUploadMg startServerWithIndexHTML:@"index.html"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.mainVC = [[DWViewController alloc] init];
    self.window.rootViewController = self.mainVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}


//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
