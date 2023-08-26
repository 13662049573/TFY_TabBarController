//
//  TfySY_TabBarController.m
//  TFY_TabarController
//
//  Created by tiandengyou on 2019/11/25.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "TfySY_TabBarController.h"
#import "TfySY_TestTabBar.h"

@interface TfySY_TabBarController ()<TfySY_TabBarDelegate>

@end

@implementation TfySY_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    TfySY_TestTabBar *testTabBar = [TfySY_TestTabBar new];
    [self setValue:testTabBar forKey:@"tabBar"];
    
    [self.tabBar setShadowImage:[UIImage new]];
}

- (void)controllerArr:(NSArray<UIViewController*>*)vcArr TabBarConfigModelArr:(NSArray<TfySY_TabBarConfigModel *>*)tabBarConfigArr {
    self.viewControllers = vcArr;

    self.tfySY_TabBar = [[TfySY_TabBar alloc] initWithTabBarConfig:tabBarConfigArr];
    
    self.tfySY_TabBar.delegate = self;
    // 8.添加覆盖到上边
    [self.tabBar addSubview:self.tfySY_TabBar];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tfySY_TabBar.frame = self.tabBar.bounds;
    if ([self.vc_delegate respondsToSelector:@selector(tfySY_LayoutSubviews)]) {
        [self.vc_delegate tfySY_LayoutSubviews];
    }
}

// 点击事件
- (void)TfySY_TabBar:(TfySY_TabBar *)tabbar selectIndex:(NSInteger)index {
    [self setSelectedIndex:index];
    if (self.vc_delegate && [self.vc_delegate respondsToSelector:@selector(TfySY_TabBar:newsVc:selectIndex:)]) {
        UIViewController *vc = self.viewControllers[index];
        [self.vc_delegate TfySY_TabBar:tabbar newsVc:vc selectIndex:index];
    }
}

//双击事件
- (void)TfySY_TabBarDoubleClick:(TfySY_TabBar *)tabbar selectIndex:(NSInteger)index {
    if (self.vc_delegate && [self.vc_delegate respondsToSelector:@selector(TfySY_TabBarDoubleClick:newsVc:selectIndex:)]) {
        UIViewController *vc = self.viewControllers[index];
        [self.vc_delegate TfySY_TabBarDoubleClick:tabbar newsVc:vc selectIndex:index];
    }
}

@end
