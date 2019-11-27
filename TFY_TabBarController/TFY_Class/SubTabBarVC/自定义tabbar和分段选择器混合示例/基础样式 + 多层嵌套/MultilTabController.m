//
//  MultilTabController.m
//  tfyTabBarController
//
//  Created by 喻平 on 15/8/11.
//  Copyright (c) 2015年 tfyTabBarController. All rights reserved.
//

#import "MultilTabController.h"
#import "ViewController.h"
#import "FixedItemWidthTabController.h"
#import "DynamicItemWidthTabController.h"
#import "SegmentTabController.h"
#import "IndicatorFollowTitleTabController.h"
#import "HeaderViewTabController.h"

@interface MultilTabController ()

@end

@implementation MultilTabController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:true animated:animated];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initViewControllers];
    self.tabBar.backgroundColor = [UIColor lightGrayColor];
    
    // 设置数字样式的badge的位置和大小
    [self.tabBar setNumberBadgeMarginTop:2
                       centerMarginRight:20
                     titleHorizonalSpace:8
                      titleVerticalSpace:2];
    // 设置小圆点样式的badge的位置和大小
    [self.tabBar setDotBadgeMarginTop:5
                    centerMarginRight:15
                           sideLength:10];
    
    UIViewController *controller2 = self.viewControllers[1];
    UIViewController *controller3 = self.viewControllers[2];
    UIViewController *controller4 = self.viewControllers[3];
    UIViewController *controller5 = self.viewControllers[4];
    controller2.tfy_tabItem.badge = 8;
    controller3.tfy_tabItem.badge = 88;
    controller4.tfy_tabItem.badge = 120;
    controller5.tfy_tabItem.badgeStyle = TabItemBadgeStyleDot;
    
    self.Style =TabarbaruseStyle;
    
//    [self.tabBar setItemContentHorizontalCenterAndMarginTop:10 spacing:-10];
}

- (void)initViewControllers {
    
    DynamicItemWidthTabController *controller1 = [[DynamicItemWidthTabController alloc] init];
    controller1.tfy_tabItemTitle = @"动态宽度";
    controller1.tfy_tabItemImage = [UIImage imageNamed:@"tab_message_normal"];
    controller1.tfy_tabItemSelectedImage = [UIImage imageNamed:@"tab_message_selected"];
    
    FixedItemWidthTabController *controller2 = [[FixedItemWidthTabController alloc] init];
    controller2.tfy_tabItemTitle = @"固定宽度";
    controller2.tfy_tabItemImage = [UIImage imageNamed:@"tab_discover_normal"];
    controller2.tfy_tabItemSelectedImage = [UIImage imageNamed:@"tab_discover_selected"];
    
    IndicatorFollowTitleTabController *controller3 = [[IndicatorFollowTitleTabController alloc] init];
    controller3.tfy_tabItemTitle = @"不滚动tab";
    controller3.tfy_tabItemImage = [UIImage imageNamed:@"tab_me_normal"];
    controller3.tfy_tabItemSelectedImage = [UIImage imageNamed:@"tab_me_selected"];
    
    SegmentTabController *controller4 = [[SegmentTabController alloc] init];
    controller4.tfy_tabItemTitle = @"系统Segment";
    controller4.tfy_tabItemImage = [UIImage imageNamed:@"tab_me_normal"];
    controller4.tfy_tabItemSelectedImage = [UIImage imageNamed:@"tab_me_selected"];
    
    HeaderViewTabController *controller5 = [[HeaderViewTabController alloc] init];
    controller5.tfy_tabItemTitle = @"HeadrView";
    controller5.tfy_tabItemImage = [UIImage imageNamed:@"tab_me_normal"];
    controller5.tfy_tabItemSelectedImage = [UIImage imageNamed:@"tab_me_selected"];
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, controller3, controller4, controller5, nil];
}


@end
