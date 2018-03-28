//
//  ChartListViewController.m
//  RongCloudDemo
//
//  Created by Primb_yqx on 17/4/26.
//  Copyright © 2017年 primb. All rights reserved.
//

#import "ChartListViewController.h"
#import "ChatViewController.h"

@interface ChartListViewController ()

@end

@implementation ChartListViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        /* 设置聊天列表显示的会话类型，在viewDidLoad之前设置,必须设置以下两个属性中的一个 */
        self.displayConversationTypeArray = @[@(ConversationType_PRIVATE),@(ConversationType_GROUP)];
        /* 按照会话类型进行列表的分类 */
        self.collectionConversationTypeArray = @[@(ConversationType_GROUP)];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.conversationListTableView.tableFooterView = [UIView new];
    /*
     // 设置空背景，可选
     self.emptyConversationView = [UIView new];
     */
}


#pragma mark - 重写函数

- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"即将显示cell，显示用户名");
//    RCConversationCell *displayCell = (RCConversationCell *)cell;
//    if (displayCell.model.conversationModelType != RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
//        displayCell.conversationTitle.text = displayCell.model.conversationTitle;
//    }
}

- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource {
    NSLog(@"数据源设置，获取用户名");
//    [dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        RCConversationModel *model = (RCConversationModel *)obj;
//        if (model.conversationModelType != RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
//            model.conversationTitle = @"用户名";
//        }
//    }];
    
    return dataSource;
}
/*
 - (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 NSLog(@"设置cell高度");
 return 50;
 }
 */

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击cell回调");
    //判断是否聚合显示
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        NSLog(@"聚合显示");
        ChartListViewController *detailVC = [[ChartListViewController alloc] initWithDisplayConversationTypes:@[@(model.conversationType)]
                                                                                   collectionConversationType:nil];
        detailVC.title = model.conversationTitle;
        /* 由聚合列表进入子列表设置，暂不知理由? */
        detailVC.isEnteredToCollectionViewController = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else {
        NSLog(@"非聚合显示");
        ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationType:model.conversationType
                                                                                 targetId:model.targetId];
        chatVC.title = model.conversationTitle;
        chatVC.conversationModel = model;
        [self.navigationController pushViewController:chatVC animated:YES];
    }
}

- (void)didTapCellPortrait:(RCConversationModel *)model {
    NSLog(@"点击头像回调");
}

- (void)didLongPressCellPortrait:(RCConversationModel *)model {
    NSLog(@"长按头像回调");
}

@end
