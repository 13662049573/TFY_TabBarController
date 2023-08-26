//
//  PushHiddenTabBarVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "PushHiddenTabBarVC.h"
#import "TestVC.h"
#import "BasicFunctionListVC.h"
#import "TestPushHiddenVC.h"
#import "TestHiddenVC.h"
#import "TestGetTabBarItemVC.h"
#import "BadgeViewController.h"
#import "ViewController.h"
@interface PushHiddenTabBarVC ()<TfySY_ControllerDelegate>

@end

@implementation PushHiddenTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子VC
    [self addChildViewControllers];

    self.vc_delegate = self;
}
- (void)addChildViewControllers{
    // 创建选项卡的数据 想怎么写看自己，这块我就写笨点了
    TFY_NavigationController *vc1 = [[TFY_NavigationController alloc] initWithRootViewController:[BasicFunctionListVC new]];
    TFY_NavigationController *vc2 = [[TFY_NavigationController alloc] initWithRootViewController:[TestHiddenVC new]];
    TFY_NavigationController *vc3 = [[TFY_NavigationController alloc] initWithRootViewController:[TestGetTabBarItemVC new]];
    TFY_NavigationController *vc4 = [[TFY_NavigationController alloc] initWithRootViewController:[BadgeViewController new]];
    TFY_NavigationController *vc5 = [[TFY_NavigationController alloc] initWithRootViewController:[ViewController new]];
    NSArray <NSDictionary *>*VCArray =
    @[@{@"vc":vc1,@"itemTitle":@"推出"},
      @{@"vc":vc2,@"itemTitle":@"隐藏"},
      @{@"vc":vc3,@"itemTitle":@"红点徽标"},
      @{@"vc":vc4,@"itemTitle":@"占位"},
      @{@"vc":vc5,@"itemTitle":@"新界面"}
      ];
    // 1.遍历这个集合
    // 1.1 设置一个保存构造器的数组
    NSMutableArray *tabBarConfs = @[].mutableCopy;
    // 1.2 设置一个保存VC的数组
    NSMutableArray *tabBarVCs = @[].mutableCopy;
    [VCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 2.根据集合来创建TabBar构造器
        TfySY_TabBarConfigModel *model = [TfySY_TabBarConfigModel new];
        model.itemLayoutStyle = TfySY_TabBarItemLayoutStyleTitle;
        model.titleLabel.font = [UIFont systemFontOfSize:14];
        // 3.item基础数据三连
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        // 4.设置单个选中item标题状态下的颜色
        model.selectColor = [UIColor orangeColor];
        model.normalColor = [UIColor whiteColor];
        model.normalTintColor = [UIColor whiteColor];
        model.selectBackgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        model.interactionEffectStyle = TfySY_TabBarInteractionEffectStyleShake;
        // 示例中为了方便就在这写了
        UIViewController *vc = [obj objectForKey:@"vc"];
        // 5.将VC添加到系统控制组
        [tabBarVCs addObject:vc];
        // 5.1添加构造Model到集合
        [tabBarConfs addObject:model];
    }];

    [self controllerArr:tabBarVCs TabBarConfigModelArr:tabBarConfs];
   
    self.tfySY_TabBar.backgroundImageView.image = [UIImage imageNamed:@"backImg"];
    self.tfySY_TabBar.translucent = YES;
}

// 点击事件
- (void)TfySY_TabBar:(TfySY_TabBar *)tabbar newsVc:(nonnull UIViewController *)vc selectIndex:(NSInteger)index {
    NSLog(@"单击：index=======:%ld",index);
}

//双击事件
- (void)TfySY_TabBarDoubleClick:(TfySY_TabBar *)tabbar newsVc:(nonnull UIViewController *)vc selectIndex:(NSInteger)index {
    NSLog(@"双击：index=======:%ld",index);
}

@end
