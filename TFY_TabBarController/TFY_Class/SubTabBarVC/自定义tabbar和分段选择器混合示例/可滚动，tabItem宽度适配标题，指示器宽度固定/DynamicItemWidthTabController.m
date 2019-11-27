//
//  DynamicItemWidthTabController.m
//  tfyTabBarController
//
//  Created by 喻平 on 16/5/20.
//  Copyright © 2016年 tfyTabBarController. All rights reserved.
//

#import "DynamicItemWidthTabController.h"
#import "RootViewController.h"
@interface DynamicItemWidthTabController ()

@end

@implementation DynamicItemWidthTabController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:true animated:animated];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.Style = NavigationbaruseStyle;
    
    self.tabBar.itemTitleColor = [UIColor lightGrayColor];
    self.tabBar.itemTitleSelectedColor = [UIColor redColor];
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:17];
    self.tabBar.itemTitleSelectedFont = [UIFont boldSystemFontOfSize:22];
    self.tabBar.leadingSpace = 20;
    self.tabBar.trailingSpace = 20;
    
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.indicatorColor = [UIColor redColor];
    
    [self.tabBar setIndicatorWidth:40 marginTop:40 marginBottom:0 tapSwitchAnimated:NO];
    
    [self.tabBar setScrollEnabledAndItemFitTextWidthWithSpacing:40];
    
    
    [self.tabContentView setContentScrollEnabled:YES tapSwitchAnimated:NO];
    self.tabContentView.loadViewOfChildContollerWhileAppear = YES;
    
    [self initViewControllers];
}


- (void)initViewControllers {
    RootViewController *controller1 = [[RootViewController alloc] init];
    controller1.tfy_tabItemTitle = @"推荐";
    
    RootViewController *controller2 = [[RootViewController alloc] init];
    controller2.tfy_tabItemTitle = @"化妆品";
    
    RootViewController *controller3 = [[RootViewController alloc] init];
    controller3.tfy_tabItemTitle = @"海外淘";
    
    RootViewController *controller4 = [[RootViewController alloc] init];
    controller4.tfy_tabItemTitle = @"第四";
    
    RootViewController *controller5 = [[RootViewController alloc] init];
    controller5.tfy_tabItemTitle = @"电子产品";
    
    RootViewController *controller6 = [[RootViewController alloc] init];
    controller6.tfy_tabItemTitle = @"第六";
    
    RootViewController *controller7 = [[RootViewController alloc] init];
    controller7.tfy_tabItemTitle = @"第七个";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, controller3, controller4, controller5, controller6, controller7, nil];
}

@end
