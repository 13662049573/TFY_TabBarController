//
//  ItemCustomAnimationTabBarVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "ItemCustomAnimationTabBarVC.h"

@interface ItemCustomAnimationTabBarVC ()<TfySY_TabBarDelegate>

@end

@implementation ItemCustomAnimationTabBarVC

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
     // 点击触发时候的交互效果
     typedef NS_ENUM(NSInteger, TfySY_TabBarInteractionEffectStyle) {
     TfySY_TabBarInteractionEffectStyleNone,     // 无 默认
     TfySY_TabBarInteractionEffectStyleSpring,   // 放大放小弹簧效果
     TfySY_TabBarInteractionEffectStyleShake,    // 摇动动画效果
     TfySY_TabBarInteractionEffectStyleAlpha,    // 透明动画效果
     TfySY_TabBarInteractionEffectStyleCustom,   // 自定义动画效果
     };
     */
    NSArray *customAnimationArray = @[@(TfySY_TabBarInteractionEffectStyleSpring), // 放大放小弹簧效果
                                  @(TfySY_TabBarInteractionEffectStyleShake),      // 摇动动画效果
                                  @(TfySY_TabBarInteractionEffectStyleAlpha),      // 透明动画效果
                                  @(TfySY_TabBarInteractionEffectStyleCustom),     // 自定义动画效果 4
                                  @(TfySY_TabBarInteractionEffectStyleCustom)];    // 自定义动画效果 5
    
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
        // 区别设置
        switch (idx) {
            case 0:
                model.itemSize = CGSizeMake(70, 40);
                break;
            case 2:
                model.itemSize = CGSizeMake(70, 40);
                model.itemBadgeStyle = TfySY_TabBarItemBadgeStyleTopRight;
                model.badge = [NSString stringWithFormat:@"%d",arc4random()%100 + 50];
                break;
            case 3:
                model.itemSize = CGSizeMake(70, 40);
                model.itemBadgeStyle = TfySY_TabBarItemBadgeStyleTopLeft;
                model.badge = [NSString stringWithFormat:@"%d",arc4random()%100 + 50];
                break;
            case 4:
                model.itemLayoutStyle = TfySY_TabBarItemLayoutStyleLeftPictureRightTitle;
                break;
            default: break;
        }
        // DEMO 设置动画模式
        /******************************************************************************/
        model.interactionEffectStyle = [customAnimationArray[idx] integerValue];
        model.tag = 100 + idx;
        // 自定义动画回调Block
        model.customInteractionEffectBlock = ^(TfySY_TabBarItem *item) {
            if (item.itemModel.tag - 100 == 3) { // 第四个
                NSLog(@"触发第四个Item的自定义动画");
                CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
                animation.keyPath = @"transform.scale";
                animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
                animation.duration = 1;
                animation.calculationMode = kCAAnimationCubic;
                [item.layer addAnimation:animation forKey:nil];
            }else if (item.itemModel.tag - 100 == 4){ // 第五个
                NSLog(@"触发第五个Item的自定义动画");
                CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
                CGFloat angle = M_PI_4 / 10;
                animation.values = @[@(-angle), @(angle), @(-angle)];
                animation.duration = 1;
                [item.layer addAnimation:animation forKey:nil];
            }else{}
        };
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
