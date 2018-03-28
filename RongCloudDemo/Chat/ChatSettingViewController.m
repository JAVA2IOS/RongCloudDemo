//
//  ChatSettingViewController.m
//  RongCloudDemo
//
//  Created by Primb_yqx on 17/4/28.
//  Copyright © 2017年 primb. All rights reserved.
//

#import "ChatSettingViewController.h"

@interface ChatSettingViewController () {
    switchToTop topHandler;
}
@end

@implementation ChatSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self inviteRemoteUsers:self.users];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSwitchToTop:(void (^)(BOOL))isTop {
    topHandler = isTop;
}


#pragma mark - 重写函数

/*!
 开闭置顶聊天的回调
 
 @param sender 点击的Switch开关
 */
- (void)onClickIsTopSwitch:(id)sender {
    NSLog(@"是否置顶：%@",self.switch_isTop ? @"是" : @"否");
    self.switch_isTop = !self.switch_isTop;
    if (topHandler) {
        topHandler(self.switch_isTop);
    }
}

/*!
 开闭新通知提醒的回调
 
 @param sender 点击的Switch开关
 */
- (void)onClickNewMessageNotificationSwitch:(id)sender {
    NSLog(@"是否提醒回调");
    self.switch_newMessageNotify = !self.switch_newMessageNotify;
}

/*!
 点击清除聊天记录的回调
 
 @param sender 清除聊天记录的按钮
 */
- (void)onClickClearMessageHistory:(id)sender {
    NSLog(@"清楚聊天记录");
}

@end
