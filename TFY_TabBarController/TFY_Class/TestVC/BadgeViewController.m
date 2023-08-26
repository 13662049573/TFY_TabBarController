//
//  BadgeViewController.m
//  TfySY_TabBar
//
//  Created by AxcLogo on 2018/8/27.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "BadgeViewController.h"
#import "TfySY_TabBarController.h"

@interface BadgeViewController ()

@end

@implementation BadgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"小圆点微标";
}

- (IBAction)click:(id)sender {
    TfySY_TabBarController *tabBarVC = (TfySY_TabBarController *)self.tabBarController;
    TfySY_TabBarItem *item = tabBarVC.tfySY_TabBar.currentSelectItem; // 因为已经到这个页面，说明就是当前的选项卡item
    item.badge = @"";
    // 内容随便设置，宽高都可以由你来决定，更开放一些，就是可能多两行代码O(∩_∩)O哈哈~
}

@end
