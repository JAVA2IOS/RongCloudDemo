//
//  AppDelegate.m
//  RongCloudDemo
//
//  Created by Primb_yqx on 17/4/24.
//  Copyright © 2017年 primb. All rights reserved.
//

#import "AppDelegate.h"
#import "TabViewController.h"

@interface AppDelegate () <RCIMUserInfoDataSource, RCIMGroupInfoDataSource>

@end

static const NSString *kUserId = @"primb1";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[RCIM sharedRCIM] initWithAppKey:@"x18ywvqfxjitc"];
    NSLog(@"正在连接融云服务器......");
    [[RCIM sharedRCIM] connectWithToken:@"tut7xn9tnTUwlw8F0y+QKJ5GhKFvBsqEb1mR+v/jdFZEoGVSO90pI24KwmX/K2MM1dh8HrysUCHuO8eeGO4e1g=="
                                success:^(NSString *userId) {
                                    NSLog(@"登录成功！需要主动切换到主线程");
                                    RCUserInfo *userInfo = [[RCUserInfo alloc] init];
                                    userInfo.name = @"用户一";
                                    userInfo.userId = @"primb1";
                                    [[RCIM sharedRCIM] setCurrentUserInfo:userInfo];
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        TabViewController *rootVC = [[TabViewController alloc] init];
                                        self.window.rootViewController = rootVC;
                                        [self.window makeKeyAndVisible];
                                    });
                                }
                                  error:^(RCConnectErrorCode status) {
                                  }
                         tokenIncorrect:^{
                             NSLog(@"id错误");
                         }];
    
    [RCIM sharedRCIM].globalNavigationBarTintColor = [UIColor blackColor];
    [RCIM sharedRCIM].userInfoDataSource = self;
    [RCIM sharedRCIM].groupInfoDataSource = self;
    
    return YES;
}

/* 实现用户信息、群组信息数据源的缓存，可以通过缓存获取用户信息 */

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    if (userId.length == 0) {
        return;
    }
    RCUserInfo *userInfo = [[RCUserInfo alloc] init];
    userInfo.userId = userId;
    userInfo.name = @"姓名";
    // 头像的url地址
    userInfo.portraitUri = @"";
    
    completion(userInfo);
}

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion {
    if (groupId.length == 0) {
        return;
    }
    RCGroup *group = [[RCGroup alloc] initWithGroupId:groupId
                                            groupName:@"群组名称"
                                          portraitUri:@""];
    completion(group);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"是否进入后台");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
