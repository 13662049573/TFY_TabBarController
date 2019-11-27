//
//  TestGetTabBarItemVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "TestGetTabBarItemVC.h"
#import "TfySY_TabBarController.h"

@interface TestGetTabBarItemVC ()
;
@property(nonatomic, assign)NSInteger badge;
@end

@implementation TestGetTabBarItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加微标";
    self.navigationController.tfy_titleColor = [UIColor whiteColor];
    self.navigationController.tfy_barBackgroundColor = [UIColor purpleColor];
}
- (IBAction)click:(id)sender {
    TfySY_TabBarController *tabBarVC = (TfySY_TabBarController *)self.tabBarController;
    TfySY_TabBarItem *item = tabBarVC.tfySY_TabBar.currentSelectItem; // 因为已经到这个页面，说明就是当前的选项卡item
    // 或者可以这么获取
//    TfySY_TabBarItem *item = tabBarVC.tfySY_TabBar.tabBarItems[2]; // 这个下标是固定的，代表这个页面下的item
    
    self.badge ++;
    item.badge = [NSString stringWithFormat:@"%ld",self.badge];
    // 为0是否自动隐藏
//    item.badgeLabel.automaticHidden = YES;
    
}


@end
