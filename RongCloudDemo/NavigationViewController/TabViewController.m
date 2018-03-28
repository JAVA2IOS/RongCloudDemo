//
//  TabViewController.m
//  RongCloudDemo
//
//  Created by Primb_yqx on 17/4/26.
//  Copyright © 2017年 primb. All rights reserved.
//

#import "TabViewController.h"
#import "ChartListViewController.h"
#import "FriendViewController.h"

@interface TabViewController () {
    NSArray *controllerNames;
    NSArray *titles;
}
@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    controllerNames = @[@"ChartListViewController",@"FriendViewController"];
    titles = @[@"会话",@"好友"];
    [self addChildViewControllers];
}

- (void)addChildViewControllers {
    for (int i = 0; i < [controllerNames count]; i ++) {
        NSString *controllerStr = [controllerNames objectAtIndex:i];
        NSString *title = [titles objectAtIndex:i];
        UIViewController *baseController = [[NSClassFromString(controllerStr) alloc] init];
        [self addChildViewController:baseController withTItle:title];
    }
}

- (void)addChildViewController:(UIViewController *)childController
                     withTItle:(NSString *) title
{
    childController.title = title;
    UINavigationController *codeZNav = [[UINavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:codeZNav];
}
@end
