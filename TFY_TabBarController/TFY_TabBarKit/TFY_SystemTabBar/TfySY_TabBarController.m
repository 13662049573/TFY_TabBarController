//
//  TfySY_TabBarController.m
//  TFY_TabarController
//
//  Created by tiandengyou on 2019/11/25.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "TfySY_TabBarController.h"

@interface TfySY_TabBarController ()

@end

@implementation TfySY_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

//    // 修改tabbar背景
//    if (@available(iOS 15.0, *)) {
//            
//        UITabBarAppearance *appearance = [UITabBarAppearance new];
//        //tabBar背景颜色
//        appearance.backgroundColor = [UIColor orangeColor];
//       // 去掉半透明效果
//        appearance.backgroundEffect = nil;
//        // tabBaritem title选中状态颜色
//        appearance.stackedLayoutAppearance.selected.titleTextAttributes = @{
//            NSForegroundColorAttributeName:UIColor.blackColor,
//            NSFontAttributeName:[UIFont systemFontOfSize:12],
//        };
//        //tabBaritem title未选中状态颜色
//        appearance.stackedLayoutAppearance.normal.titleTextAttributes =  @{
//            NSForegroundColorAttributeName:UIColor.lightTextColor,
//            NSFontAttributeName:[UIFont systemFontOfSize:12],
//        };
//        self.tabBar.scrollEdgeAppearance = appearance;
//        self.tabBar.standardAppearance = appearance;
//    }
    
    [self.tabBar setShadowImage:[UIImage new]];
    
}

-(void)setControllerArray:(NSArray<UIViewController *> *)ControllerArray{
    _ControllerArray = ControllerArray;
    self.viewControllers = _ControllerArray;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    if(self.tfySY_TabBar){
        self.tfySY_TabBar.selectIndex = selectedIndex;
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tfySY_TabBar.frame = self.tabBar.bounds;
    if ([self.vc_delegate respondsToSelector:@selector(tfySY_LayoutSubviews)]) {
        [self.vc_delegate tfySY_LayoutSubviews];
    }
}

@end
