//
//  BulgeSquareTabBarVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "BulgeSquareTabBarVC.h"

@interface BulgeSquareTabBarVC ()<TfySY_TabBarDelegate>

@end

@implementation BulgeSquareTabBarVC

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
        /** 其他item颜色 ************************/
        // 选中为白色
        model.selectBackgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        // 文字选中色为橘色
        model.selectColor = [UIColor orangeColor];
        // 文字选中色为白色
        model.normalColor = [UIColor whiteColor];
        // 图片选中橘色
        model.selectTintColor = [UIColor orangeColor];
        // 图片未选中白色
        model.normalTintColor = [UIColor whiteColor];
        
        /***********************************/
        if (idx == 2 ) { // 如果是中间的
            // 设置凸出
            model.bulgeStyle = TfySY_TabBarConfigBulgeStyleSquare;
            // 设置凸出高度
            model.bulgeHeight = 10;
            // 设置成纯图片展示
            model.itemLayoutStyle = TfySY_TabBarItemLayoutStylePicture;
            // 稍微修饰个小圆角
            model.bulgeRoundedCorners = 10;
            // 设置图片
            model.selectImageName = @"CenterAdd";
            model.normalImageName = @"CenterAdd";
            // 设置图片大小
            model.icomImgViewSize = CGSizeMake(30, 30);
            
            /** 图片颜色 ************************/
            // 未选中橘色
            model.normalTintColor = [UIColor orangeColor];
            // 选中白色
            model.selectTintColor = [UIColor whiteColor];
            /***********************************/
            /** 背景颜色 ************************/
            // 未选中状态是白色
            model.normalBackgroundColor = [UIColor whiteColor];
            // 选中为橘里橘气
            model.selectBackgroundColor = [UIColor orangeColor];
            /***********************************/
            // 设置大小/边长
            model.itemSize = CGSizeMake(60, 50); // 自动以长款中最大值进行切圆
        }
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
    self.tfySY_TabBar.backgroundImageView.image = [UIImage imageNamed:@"backImg"];
}

@end
