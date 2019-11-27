//
//  FixedItemWidthTabController.m
//  YPTabBarController
//
//  Created by 喻平 on 16/5/13.
//  Copyright © 2016年 YPTabBarController. All rights reserved.
//

#import "FixedItemWidthTabController.h"
#import "RootViewController.h"
@interface FixedItemWidthTabController ()

@end

@implementation FixedItemWidthTabController
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
    self.tabBar.itemTitleSelectedFont = [UIFont systemFontOfSize:22];

    [self.tabBar setScrollEnabledAndItemWidth:80];
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.indicatorColor = [UIColor redColor];
    
    [self.tabBar setIndicatorWidthFitTextAndMarginTop:40 marginBottom:0 widthAdditional:5 tapSwitchAnimated:YES];
    
    self.tabContentView.defaultSelectedTabIndex = 1;
    
    self.tabBar.indicatorAnimationStyle = TabBarIndicatorAnimationStyle1;
    
    [self.tabContentView setContentScrollEnabled:YES tapSwitchAnimated:NO];
    
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
    controller1.tfy_tabItemTitle = @"第一个";
    
    
    RootViewController *controller2 = [[RootViewController alloc] init];
    controller2.tfy_tabItemTitle = @"第二";
    
    RootViewController *controller3 = [[RootViewController alloc] init];
    controller3.tfy_tabItemTitle = @"第三个";
    
    RootViewController *controller4 = [[RootViewController alloc] init];
    controller4.tfy_tabItemTitle = @"第四";
    
    RootViewController *controller5 = [[RootViewController alloc] init];
    controller5.tfy_tabItemTitle = @"第五个";
    
    RootViewController *controller6 = [[RootViewController alloc] init];
    controller6.tfy_tabItemTitle = @"第六";
    
    RootViewController *controller7 = [[RootViewController alloc] init];
    controller7.tfy_tabItemTitle = @"第七";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, controller3, controller4, controller5, controller6, controller7, nil];
    
}

@end
