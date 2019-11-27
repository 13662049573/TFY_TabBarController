//
//  IndicatorFollowTitleTabController.m
//  YPTabBarController
//
//  Created by 喻平 on 16/5/25.
//  Copyright © 2016年 YPTabBarController. All rights reserved.
//

#import "IndicatorFollowTitleTabController.h"
#import "MineController.h"

@interface IndicatorFollowTitleTabController ()

@end

@implementation IndicatorFollowTitleTabController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:true animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewControllers];
    
    self.Style = NavigationbaruseStyle;
    
    self.tabBar.backgroundColor = [UIColor grayColor];
    
    self.tabBar.itemTitleColor = [UIColor purpleColor];
    self.tabBar.itemTitleSelectedColor = [UIColor whiteColor];
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:18];
    self.tabBar.itemTitleSelectedFont = [UIFont boldSystemFontOfSize:18];
    
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.itemColorChangeFollowContentScroll = YES;
    
    self.tabBar.indicatorColor = [UIColor redColor];
    [self.tabBar setIndicatorWidthFitTextAndMarginTop:40 marginBottom:0 widthAdditional:0 tapSwitchAnimated:YES];
    self.tabBar.indicatorAnimationStyle = TabBarIndicatorAnimationStyle1;
    
    [self.tabContentView setContentScrollEnabled:YES tapSwitchAnimated:NO];
    
    [self.tfy_tabItem setDoubleTapHandler:^{
        NSLog(@"双击效果");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initViewControllers {
    MineController *controller1 = [[MineController alloc] init];
    controller1.tfy_tabItemTitle = @"第一";
    
    MineController *controller2 = [[MineController alloc] init];
    controller2.tfy_tabItemTitle = @"第二个";
    
    MineController *controller3 = [[MineController alloc] init];
    controller3.tfy_tabItemTitle = @"第三";
    
    MineController *controller4 = [[MineController alloc] init];
    controller4.tfy_tabItemTitle = @"第四个";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, controller3, controller4, nil];
    
}

@end
