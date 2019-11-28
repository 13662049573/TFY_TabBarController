//
//  HeaderViewTabController.m
//  tfyTabBarController
//
//  Created by 喻平 on 2017/9/25.
//  Copyright © 2017年 tfyTabBarController. All rights reserved.
//

#import "HeaderViewTabController.h"
#import "TableViewController.h"
#import "WebViewController.h"

@interface HeaderViewTabController ()

@end

#define TfySY_IsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ((NSInteger)(([[UIScreen mainScreen] currentMode].size.height/[[UIScreen mainScreen] currentMode].size.width)*100) == 216) : NO)

#define kTFY_TabBar_NavBarHeight           (TfySY_IsiPhoneX ? 88.0 : 64.0)

@implementation HeaderViewTabController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:true animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabContentView.interceptRightSlideGuetureInFirstPage = YES;
    
    self.tabBar.itemTitleColor = [UIColor lightGrayColor];
    self.tabBar.itemTitleSelectedColor = [UIColor redColor];
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:17];
    self.tabBar.itemTitleSelectedFont = [UIFont systemFontOfSize:22];
    
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.indicatorColor = [UIColor redColor];
    [self.tabBar setIndicatorInsets:UIEdgeInsetsMake(40, 10, 0, 10) tapSwitchAnimated:NO];
    
    self.tfy_tabItem.badgeStyle = TabItemBadgeStyleDot;
    
    self.tabContentView.loadViewOfChildContollerWhileAppear = YES;
    

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_herder"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    [self.tabContentView setHeaderView:imageView style:TabHeaderStyleStretch headerHeight:250 tabBarHeight:44 tabBarStopOnTopHeight:kTFY_TabBar_NavBarHeight frame:frame];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 20, 50, 40);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    [self initViewControllers];
}


- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initViewControllers {
    TableViewController *controller1 = [[TableViewController alloc] init];
    controller1.tfy_tabItemTitle = @"第一个";
    
    WebViewController *controller2 = [[WebViewController alloc] init];
    controller2.tfy_tabItemTitle = @"第二";
    
    TableViewController *controller3 = [[TableViewController alloc] init];
    controller3.tfy_tabItemTitle = @"第三个";
    controller3.numberOfRows = 5;
    
    TableViewController *controller4 = [[TableViewController alloc] init];
    controller4.tfy_tabItemTitle = @"第四";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, controller3, controller4, nil];
    
}

- (void)tabContentView:(TfyCU_TabBarView *)tabConentView didChangedContentOffsetY:(CGFloat)offsetY {
    NSLog(@"offsetY-->%f", offsetY);
}

@end
