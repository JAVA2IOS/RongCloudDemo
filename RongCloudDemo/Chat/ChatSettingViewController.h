//
//  ChatSettingViewController.h
//  RongCloudDemo
//
//  Created by Primb_yqx on 17/4/28.
//  Copyright © 2017年 primb. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

typedef void(^switchToTop)(BOOL);

@interface ChatSettingViewController : RCConversationSettingTableViewController

/**
 切换聊天置顶响应

 @param isTop 是否置顶
 */
- (void)didSwitchToTop:(void(^)(BOOL isTop))isTop;
@end
