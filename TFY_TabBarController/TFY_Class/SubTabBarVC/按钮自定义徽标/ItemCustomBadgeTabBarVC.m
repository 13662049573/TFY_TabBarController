//
//  ItemCustomBadgeTabBarVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "ItemCustomBadgeTabBarVC.h"

@interface ItemCustomBadgeTabBarVC ()<TfySY_TabBarDelegate>

@end

@implementation ItemCustomBadgeTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子VC
    [self addChildViewControllers];
}

- (void)addChildViewControllers{
    // 创建选项卡的数据 想怎么写看自己，这块我就写笨点了
    NSArray <NSDictionary *>*VCArray =
    @[@{@"vc":[UIViewController new],@"normalImg":@"homePage",@"selectImg":@"homePage_select",@"itemTitle":@"Tfy_UIKit"},
      @{@"vc":[UIViewController new],@"normalImg":@"task",@"selectImg":@"task_select",@"itemTitle":@"Tfy_FormList"},
      @{@"vc":[UIViewController new],@"normalImg":@"complaint",@"selectImg":@"complaint_select",@"itemTitle":@"Tfy_LineUI"},
      @{@"vc":[UIViewController new],@"normalImg":@"home_activity",@"selectImg":@"home_activity_select",@"itemTitle":@"Tfy_PopUI"},
      @{@"vc":[UIViewController new],@"normalImg":@"me",@"selectImg":@"me_select",@"itemTitle":@"Tfy_MultiUI"}];
    //DEMO 自定义布局数组
    /*
     // item的Badge脚标方位
     typedef NS_ENUM(NSInteger, TfySY_TabBarItemBadgeStyle) {
     TfySY_TabBarItemBadgeStyleTopRight = 0,   // 右上方 默认
     TfySY_TabBarItemBadgeStyleTopCenter,      // 上中间
     TfySY_TabBarItemBadgeStyleTopLeft         // 左上方
     };
     */
    NSArray *customBadgeArray = @[@(TfySY_TabBarItemBadgeStyleTopRight),     // 右上方 默认
                                  @(TfySY_TabBarItemBadgeStyleTopRight),     // 右上方 默认
                                  @(TfySY_TabBarItemBadgeStyleTopCenter),   // 上中间
                                  @(TfySY_TabBarItemBadgeStyleTopLeft),     // 左上方
                                  @(TfySY_TabBarItemBadgeStyleTopLeft)];     // 左上方
    
    // 1.遍历这个集合
    // 1.1 设置一个保存构造器的数组
    NSMutableArray *tabBarConfs = @[].mutableCopy;
    // 1.2 设置一个保存VC的数组
    NSMutableArray *tabBarVCs = @[].mutableCopy;
    [VCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 2.根据集合来创建TabBar构造器
        TfySY_TabBarConfigModel *model = [TfySY_TabBarConfigModel new];
        // 3.item基础数据三连
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        model.selectImageName = [obj objectForKey:@"selectImg"];
        model.normalImageName = [obj objectForKey:@"normalImg"];
        // 4.设置单个选中item标题状态下的颜色
        model.selectColor = [UIColor orangeColor];
        // 大小
        model.itemSize = CGSizeMake(70, 40);
        // DEMO 设置布局模式
        /******************************************************************************/
        model.itemBadgeStyle = [customBadgeArray[idx] integerValue];
        model.badge = [NSString stringWithFormat:@"%d",arc4random()%100 + 50];
        // 为了方便观察设置背景颜色
        model.normalBackgroundColor = [UIColor lightGrayColor];
        /******************************************************************************/
        
        // 备注 如果一步设置的VC的背景颜色，VC就会提前绘制驻留，优化这方面的话最好不要这么写
        // 示例中为了方便就在这写了
        UIViewController *vc = [obj objectForKey:@"vc"];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f
                                                  green:arc4random()%255/255.f
                                                   blue:arc4random()%255/255.f alpha:1];
        // 5.将VC添加到系统控制组
        [tabBarVCs addObject:vc];
        // 5.1添加构造Model到集合
        [tabBarConfs addObject:model];
    }];
    [self controllerArr:tabBarVCs TabBarConfigModelArr:tabBarConfs];
    
}

@end
