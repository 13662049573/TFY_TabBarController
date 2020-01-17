//
//  PushHiddenTabBarVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "PushHiddenTabBarVC.h"
#import "TestVC.h"
#import "ModelViewController.h"
#import "TestPushHiddenVC.h"
#import "TestHiddenVC.h"
#import "TestGetTabBarItemVC.h"
#import "BadgeViewController.h"
#import "ViewController.h"
@interface PushHiddenTabBarVC ()<TfySY_TabBarDelegate>

@end

@implementation PushHiddenTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子VC
    [self addChildViewControllers];

}
- (void)addChildViewControllers{
    // 创建选项卡的数据 想怎么写看自己，这块我就写笨点了
    TFY_NavigationController *vc1 = [[TFY_NavigationController alloc] initWithRootViewController:[ModelViewController new]];
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
    // 5.2 设置VCs -----
    // 一定要先设置这一步，然后再进行后边的顺序，因为系统只有在setViewControllers函数后才不会再次创建UIBarButtonItem，以免造成遮挡
    // 大意就是一定要让自定义TabBar遮挡住系统的TabBar
    self.ControllerArray = tabBarVCs;
    //////////////////////////////////////////////////////////////////////////
    // 注：这里方便阅读就将TfySY_TabBar放在这里实例化了 使用懒加载也行
    // 6.将自定义的覆盖到原来的tabBar上面
    // 这里有两种实例化方案：
    // 6.1 使用重载构造函数方式：
    self.tfySY_TabBar = [[TfySY_TabBar alloc] initWithTabBarConfig:tabBarConfs];
    // 7.设置委托
    self.tfySY_TabBar.delegate = self;
    // DEMO 设置背景图片
    self.tfySY_TabBar.backgroundImageView.image = [UIImage imageNamed:@"backImg"];
    /******************************************************************************/
    // 开启模糊毛玻璃半透效果
    self.tfySY_TabBar.translucent = YES;
    /******************************************************************************/
    // 8.添加覆盖到上边
    [self.tabBar addSubview:self.tfySY_TabBar];
    
}
// 9.实现代理，如下：
- (void)TfySY_TabBar:(TfySY_TabBar *)tabbar selectIndex:(NSInteger)index{
    // 通知 切换视图控制器
    [self setSelectedIndex:index];
    // 自定义的AE_TabBar回调点击事件给TabBarVC，TabBarVC用父类的TabBarController函数完成切换
}


@end
