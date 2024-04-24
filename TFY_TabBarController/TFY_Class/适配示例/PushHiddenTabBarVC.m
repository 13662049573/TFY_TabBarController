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
    TestHiddenVC *vc2 = TestHiddenVC.new;
    TestGetTabBarItemVC *vc3 = TestGetTabBarItemVC.new;
    BadgeViewController *vc4 = BadgeViewController.new;
    ViewController *vc5 = ViewController.new;
    NSArray <NSDictionary *>*VCArray =
    @[
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
        
        model.interactionEffectStyle = TfySY_TabBarInteractionEffectStyleShake;
       
        // 示例中为了方便就在这写了
        UIViewController *vc = [obj objectForKey:@"vc"];
        TFY_NavigationController *nav = [[TFY_NavigationController alloc] initWithRootViewController:vc];
        // 5.将VC添加到系统控制组
        [tabBarVCs addObject:nav];
        // 5.1添加构造Model到集合
        [tabBarConfs addObject:model];
    }];

    [self controllerArr:tabBarVCs TabBarConfigModelArr:tabBarConfs];
   //
    self.tfySY_TabBar.themeImage = [UIImage imageNamed:@"backimage"];
    self.tfySY_TabBar.backgroundSelectImageView.image = [UIImage imageNamed:@"backselect"];
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
