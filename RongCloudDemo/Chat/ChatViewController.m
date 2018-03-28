//
//  ChatViewController.m
//  RongCloudDemo
//
//  Created by Primb_yqx on 17/4/26.
//  Copyright © 2017年 primb. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatSettingViewController.h"
#import "ChatSettingTwoViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
    /*
     // 是否显示发送用户名，默认YES
     self.displayUserNameInCell = NO;
     // 是否显示右上角提示未读信息，默认NO
     self.enableUnreadMessageIcon = YES;
     // 是否显示右下角提示未读信息，默认NO
     self.enableNewComingMessageIcon = YES;
     */
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self chatSettingViewController];
    // 导航栏左边显示未读会话的类型
    self.displayConversationTypeArray = @[@(ConversationType_GROUP),@(ConversationType_PRIVATE)];
    // 聊天界面背景
//    self.conversationMessageCollectionView.backgroundColor = [UIColor whiteColor];
}

// 导航栏左右键设置
- (UIBarButtonItem *)withNormalImage:(NSString *)image target:(id)target action:(SEL)action{
    UIImage *normalImage = [RCKitUtility imageNamed:image ofBundle:@"RongCloud.bundle"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

// 添加导航栏右键
- (void)chatSettingViewController {
    self.navigationItem.rightBarButtonItem =[self withNormalImage:@"custom_service_switch_to_admin" target:self action:@selector(chatSetting)];
}

// 聊天设置
- (void)chatSetting {
    /*
     两种聊天设置页面
     */
    ChatSettingViewController *chatSetVC = [[ChatSettingViewController alloc] init];
    ChatSettingTwoViewController *chatTwoSetVC = [[ChatSettingTwoViewController alloc] init];
    if (self.conversationType == ConversationType_PRIVATE) {
        NSLog(@"targetId: %@",self.targetId);
        if (self.targetId.length == 0 || !self.targetId) {
            return;
        }else if (![[RCIM sharedRCIM] getUserInfoCache:self.targetId]) {
            RCUserInfo *userInfo = [[RCUserInfo alloc] init];
            userInfo.userId = self.targetId;
            userInfo.name = self.title;
            userInfo.portraitUri = @"";
            [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:self.targetId];
        }
        chatSetVC.users = @[[[RCIM sharedRCIM] getUserInfoCache:self.targetId]];
        __weak typeof(self) weakSelf = self;
        [chatSetVC didSwitchToTop:^(BOOL isTop) {
            // 是否置顶聊天
            weakSelf.conversationModel.isTop = isTop;
        }];
        chatTwoSetVC.users = @[[[RCIM sharedRCIM] getUserInfoCache:self.targetId]];
        chatTwoSetVC.clearHistoryCompletion = ^(BOOL success) {
            // 清除历史记录回调，需要手动reloadData刷新聊天界面信息
        };
    }else if (self.conversationType == ConversationType_GROUP) {
        NSLog(@"群组设置，需要实现RCIMGroupMemberDataSource协议，可以通过该协议获取群成员数据");
        return;
    }else {
        NSLog(@"其他类型");
        return;
    }
    [self.navigationController pushViewController:chatSetVC animated:YES];
}


#pragma mark - 重写函数
- (void)leftBarButtonItemPressed:(id)sender {
    [super leftBarButtonItemPressed:sender];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    RCMessageCell *displayCell = (RCMessageCell *)cell;
    /* 获取每个cell的数据源 */
    RCMessageModel *model = self.conversationDataRepository[indexPath.row];
    displayCell.nicknameLabel.text = [NSString stringWithFormat:@"用户ID：%@",model.senderUserId];
}


#pragma mark - 点击事件

- (void)didTapMessageCell:(RCMessageModel *)model {
    [super didTapMessageCell:model];
    NSLog(@"cell点击事件回调，cell消息的类型：%@",model.objectName);
}

- (void)didLongTouchMessageCell:(RCMessageModel *)model inView:(UIView *)view {
    [super didLongTouchMessageCell:model inView:view];
    NSLog(@"长按，调用super方法保留原有功能");
}

- (void)didTapCellPortrait:(NSString *)userId {
    NSLog(@"点击头像回调");
}

- (void)didLongPressCellPortrait:(NSString *)userId {
    NSLog(@"长按头像回调");
}

- (void)didSendMessage:(NSInteger)stauts content:(RCMessageContent *)messageCotent {
    [super didSendMessage:stauts content:messageCotent];
    NSLog(@"发送完消息回调");
}

- (void)didTapUrlInMessageCell:(NSString *)url model:(RCMessageModel *)model {
    NSLog(@"点击消息中的url地址回调");
}

- (void)didTapPhoneNumberInMessageCell:(NSString *)phoneNumber model:(RCMessageModel *)model {
    NSLog(@"点击消息中的电话号码回调");
}

@end
