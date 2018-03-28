//
//  FriendViewController.m
//  RongCloudDemo
//
//  Created by Primb_yqx on 17/4/27.
//  Copyright © 2017年 primb. All rights reserved.
//

#import "FriendViewController.h"
#import "AddFriendViewController.h"
#import "ChatViewController.h"

@interface FriendViewController () <UITableViewDelegate, UITableViewDataSource>{
    UITableView *friendTableView;
    NSArray *modelDataSource;
}
@end

@implementation FriendViewController
- (void)viewWillAppear:(BOOL)animated {
    /* 可以在加载之前获取好友信息，然后加载数据，好友数据可以从本地数据库当中获取，然后建立RCUserInfo数据组 */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addFriendViewController];
    [self friend_initFriendListView];
    
    RCConversation *conversation2 = [[RCConversation alloc] init];
    conversation2.targetId = @"primb2";
    conversation2.conversationType = ConversationType_PRIVATE;
    RCConversationModel *model2 = [[RCConversationModel alloc] init:RC_CONVERSATION_MODEL_TYPE_NORMAL
                                                       conversation:conversation2
                                                             extend:nil];
    model2.extend = @"Li";
    
    RCConversation *conversation3 = [[RCConversation alloc] init];
    conversation3.targetId = @"primb3";
    conversation3.conversationType = ConversationType_PRIVATE;
    RCConversationModel *model3 = [[RCConversationModel alloc] init:RC_CONVERSATION_MODEL_TYPE_NORMAL
                                                       conversation:conversation3
                                                             extend:nil];
    model3.extend = @"Tom";
    
    RCConversation *conversation4 = [[RCConversation alloc] init];
    conversation4.targetId = @"primb4";
    conversation4.conversationType = ConversationType_PRIVATE;
    RCConversationModel *model4 = [[RCConversationModel alloc] init:RC_CONVERSATION_MODEL_TYPE_NORMAL
                                                       conversation:conversation4
                                                             extend:nil];
    model4.extend = @"Ryu";
    
    modelDataSource = @[model2,model3,model4];
}

// 添加导航栏右键
- (void)addFriendViewController {
    self.navigationItem.rightBarButtonItem =[self withNormalImage:@"add_members" target:self action:@selector(friend_AddFriend)];
}

/*
 - (void)back {
 [self.navigationController popViewControllerAnimated:YES];
 }
 */

// 添加好友界面
- (void)friend_AddFriend {
    AddFriendViewController *addFriendVC = [[AddFriendViewController alloc] init];
    [self.navigationController pushViewController:addFriendVC animated:YES];
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

// 好友主界面
- (void)friend_initFriendListView {
    friendTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SELFVIEWWIDTH, SELFVIEWHEIGHT - 0)];
    [self.view addSubview:friendTableView];
    friendTableView.tableFooterView = [UIView new];
    friendTableView.delegate = self;
    friendTableView.dataSource = self;
    if ([friendTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [friendTableView setSeparatorInset:UIEdgeInsetsMake(0, 14, 0, 0)];
    }
    if ([friendTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [friendTableView setLayoutMargins:UIEdgeInsetsMake(0, 14, 0, 0)];
    }
    friendTableView.separatorColor = UIColorFromRGB(0xdfdfdf);
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RCConversationModel *model = modelDataSource[indexPath.row];
    ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationType:model.conversationType
                                                                             targetId:model.targetId];
    chatVC.title = model.extend;
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [modelDataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCConversationBaseCell *cell;
    NSString *cellId = @"friendCellId";
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[RCConversationBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   //设置cell右边箭头类型
    
    RCConversationModel *model = modelDataSource[indexPath.row];
    cell.imageView.image = [RCKitUtility imageNamed:@"default_portrait" ofBundle:@"RongCloud.bundle"];
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 5.0f;
    cell.textLabel.text = model.extend;
    cell.model = model;
    
    return cell;
}

@end
