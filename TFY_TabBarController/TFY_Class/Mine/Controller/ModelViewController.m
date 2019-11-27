//
//  ModelViewController.m
//  TFY_TabarController
//
//  Created by 田风有 on 2019/7/29.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "ModelViewController.h"
#import "RecommendController.h"
#import "CalendarController.h"

@interface ModelViewController ()

@end

@implementation ModelViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:true animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Style = NavigationbaruseStyle;
    
    self.tabBar.itemTitleColor = [UIColor lightGrayColor];
    self.tabBar.itemTitleSelectedColor = [UIColor redColor];
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:14];
    self.tabBar.itemTitleSelectedFont = [UIFont boldSystemFontOfSize:21];
    self.tabBar.leadingSpace = 20;
//    self.tabBar.trailingSpace = 10;
    
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.indicatorColor = [UIColor redColor];
    
    [self.tabBar setIndicatorWidth:43 marginTop:41 marginBottom:0 tapSwitchAnimated:YES];
    
    [self.tabBar setScrollEnabledAndItemFitTextWidthWithSpacing:24];
    
    //是否支持滑动
    [self.tabContentView setContentScrollEnabled:YES tapSwitchAnimated:YES];
    self.tabContentView.loadViewOfChildContollerWhileAppear = YES;
        
    [self initViewControllers];
}

- (void)initViewControllers {
    RecommendController *controller1 = [[RecommendController alloc] init];
    controller1.tfy_tabItemTitle = @"首页";
    
    CalendarController *controller2 = [[CalendarController alloc] init];
    controller2.tfy_tabItemTitle = @"日历";
        
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, nil];
}


@end
