
//
//  WHGradientHelperGradientTabBarVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "WHGradientHelperGradientTabBarVC3.h"
#import "WHGradientHelper.h"

@interface WHGradientHelperGradientTabBarVC3 ()<TfySY_TabBarDelegate>

@end

@implementation WHGradientHelperGradientTabBarVC3

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
        // 4.设置单个选中item的颜色
        model.selectColor = [UIColor whiteColor];
        model.normalColor = TfySY_TabBarRGB(65, 29, 53);
        
        model.selectTintColor = [UIColor whiteColor];
        model.normalTintColor = TfySY_TabBarRGB(65, 29, 53);
        
        switch (idx) {
            case 0:
                model.selectBackgroundColor = [UIColor redColor];
                break;
            case 1:
            case 3:
                model.selectBackgroundColor =  TfySY_TabBarRGB(190, 45, 55);
                break;
            case 2:
                model.selectBackgroundColor = TfySY_TabBarRGB(194, 109, 119);
                break;
            case 4:
                model.selectBackgroundColor = [UIColor orangeColor];
                break;
            default: break;
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
    self.tfySY_TabBar.backgroundImageView.image = [WHGradientHelper getLinearGradientImage:[UIColor redColor]
                                                                                    and:[UIColor orangeColor]
                                                                          directionType:WHLinearGradientDirectionLevel];
}

@end
