//
//  JianShuTabBarVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "JianShuTabBarVC.h"

@interface JianShuTabBarVC ()<TfySY_ControllerDelegate>

@end

@implementation JianShuTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子VC
    
    self.vc_delegate = self;
    
    [self addChildViewControllers];
}
- (void)addChildViewControllers{
    // 创建选项卡的数据 想怎么写看自己，这块我就写笨点了
    NSArray <NSDictionary *>*VCArray =
    @[@{@"vc":[UIViewController new],@"normalImg":@"icon_tabbar_home_no",@"selectImg":@"icon_tabbar_home",@"itemTitle":@"发现"},
      @{@"vc":[UIViewController new],@"normalImg":@"icon_tabbar_subscription_no",@"selectImg":@"icon_tabbar_subscription",@"itemTitle":@"关注"},
      @{@"vc":[UIViewController new],@"normalImg":@"",@"selectImg":@"",@"itemTitle":@" "},
      @{@"vc":[UIViewController new],@"normalImg":@"icon_tabbar_notification_no",@"selectImg":@"icon_tabbar_notification",@"itemTitle":@"消息"},
      @{@"vc":[UIViewController new],@"normalImg":@"icon_tabbar_me_no",@"selectImg":@"icon_tabbar_me",@"itemTitle":@"我的"}];
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
        model.selectColor = TfySY_TabBarRGB(224, 111, 97);
        model.normalColor = TfySY_TabBarRGB(140, 140, 140);
        
        /***********************************/
        if (idx == 2 ) { // 如果是中间的
            CGFloat height = self.tabBar.frame.size.height - 10;
            // 设置凸出
            model.bulgeStyle = TfySY_TabBarConfigBulgeStyleSquare;
            // 设置凸出高度
            model.bulgeHeight = -5;
            model.bulgeRoundedCorners = height/2; // 修角
            // 设置成纯图片展示
            model.itemLayoutStyle = TfySY_TabBarItemLayoutStylePicture;
            model.normalImageName = model.selectImageName = @"button_write";
            model.componentMargin = UIEdgeInsetsMake(0, 0, 0, 0);// 无边距
            // 设置大小/边长
            model.itemSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 15.0 ,height);
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
    // 9.实现代理，如下：
   
}

- (void)TfySY_TabBar:(TfySY_TabBar *)tabbar newsVc:(UIViewController *)vc selectIndex:(NSInteger)index {
    if (index == 2) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击了中间的,不切换视图"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"好的！！！！");
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
