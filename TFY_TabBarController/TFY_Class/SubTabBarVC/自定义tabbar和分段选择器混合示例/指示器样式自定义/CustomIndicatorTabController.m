//
//  CustomIndicatorTabController.m
//  YPTabBarController
//
//  Created by 喻平 on 16/5/25.
//  Copyright © 2016年 YPTabBarController. All rights reserved.
//

#import "CustomIndicatorTabController.h"
#import "RootViewController.h"

@interface CustomIndicatorTabController ()

@end

@implementation CustomIndicatorTabController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:true animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.Style = NavigationbaruseStyle;
    
    self.tabBar.backgroundColor = [UIColor grayColor];
    
    self.tabBar.itemTitleColor = [UIColor purpleColor];
    self.tabBar.itemTitleSelectedColor = [UIColor whiteColor];
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:18];
    
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.itemColorChangeFollowContentScroll = YES;
    
    self.tabBar.indicatorColor = [UIColor redColor];
    [self.tabBar setIndicatorWidthFitTextAndMarginTop:8 marginBottom:8 widthAdditional:20 tapSwitchAnimated:YES];
    self.tabBar.indicatorCornerRadius = 14;
    
    [self.tabContentView setContentScrollEnabled:YES tapSwitchAnimated:YES];
    
    [self.tfy_tabItem setDoubleTapHandler:^{
        NSLog(@"双击效果");
    }];
    
    [self initViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initViewControllers {
    RootViewController *controller1 = [[RootViewController alloc] init];
    controller1.tfy_tabItemTitle = @"第一";
    
    RootViewController *controller2 = [[RootViewController alloc] init];
    controller2.tfy_tabItemTitle = @"第二个";
    
    RootViewController *controller3 = [[RootViewController alloc] init];
    controller3.tfy_tabItemTitle = @"第三";
    
    RootViewController *controller4 = [[RootViewController alloc] init];
    controller4.tfy_tabItemTitle = @"第四个";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, controller3, controller4, nil];
    
    
}

@end
