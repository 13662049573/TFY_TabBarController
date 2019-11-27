//
//  SegmentTabController.m
//  YPTabBarController
//
//  Created by 喻平 on 16/5/23.
//  Copyright © 2016年 YPTabBarController. All rights reserved.
//

#import "SegmentTabController.h"
#import "RootViewController.h"
#import "TableViewController.h"

@interface SegmentTabController ()

@end

@implementation SegmentTabController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:true animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewControllers];
    
    self.Style = NavigationbaruseStyle;
    
    self.tabBar.itemTitleColor = [UIColor redColor];
    self.tabBar.itemTitleSelectedColor = [UIColor whiteColor];
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:15];
    self.tabBar.indicatorColor = [UIColor blueColor];
    self.tabBar.layer.cornerRadius = 5;
    self.tabBar.layer.borderWidth = 1;
    self.tabBar.layer.borderColor = [UIColor blueColor].CGColor;
    [self.tabBar setItemSeparatorColor:[UIColor blueColor]
                             thickness:1
                               leading:0
                              trailing:0];
    
    UIViewController *controller1 = self.viewControllers[0];
    UIViewController *controller2 = self.viewControllers[1];
    UIViewController *controller3 = self.viewControllers[2];
    controller1.tfy_tabItem.badge = 8;
    controller2.tfy_tabItem.badge = 88;
    controller3.tfy_tabItem.badgeStyle = TabItemBadgeStyleDot;
    
    self.tabBar.badgeTitleFont = [UIFont systemFontOfSize:10];
    
    [self.tabBar setNumberBadgeMarginTop:2 centerMarginRight:25 titleHorizonalSpace:10 titleVerticalSpace:4];
    
    [self.tabBar setDotBadgeMarginTop:5 centerMarginRight:15 sideLength:8];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initViewControllers {
    RootViewController *controller1 = [[RootViewController alloc] init];
    controller1.tfy_tabItemTitle = @"第一";
    
    RootViewController *controller2 = [[RootViewController alloc] init];
    controller2.tfy_tabItemTitle = @"第二";
    
    RootViewController *controller3 = [[RootViewController alloc] init];
    controller3.tfy_tabItemTitle = @"第三";

    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, controller3, nil];
}

@end
