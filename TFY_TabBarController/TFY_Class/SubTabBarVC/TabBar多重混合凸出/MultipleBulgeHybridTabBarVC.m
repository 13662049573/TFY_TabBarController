//
//  MultipleBulgeHybridTabBarVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "MultipleBulgeHybridTabBarVC.h"

@interface MultipleBulgeHybridTabBarVC ()<TfySY_TabBarDelegate>

@end

@implementation MultipleBulgeHybridTabBarVC

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
        
        if (idx % 2 == 0) { // 如果是偶数
            // 设置凸出模式
            if (idx == 2) { // 中间的变方形
                model.bulgeStyle = TfySY_TabBarConfigBulgeStyleSquare;
                // 凸出高度 25pt
                model.bulgeHeight = 25;
                // 切个小圆角
                model.bulgeRoundedCorners = 5;
            }else{
                model.bulgeStyle = TfySY_TabBarConfigBulgeStyleCircular;
                // 凸出高度 20pt
                model.bulgeHeight = 20;
            }
            // 设置成纯文字展示
            model.itemLayoutStyle = TfySY_TabBarItemLayoutStyleTitle;
            // 文字为加号
            model.itemTitle = @"+";
            // 字号大小
            model.titleLabel.font = [UIFont systemFontOfSize:50];
            model.normalColor = [UIColor grayColor]; // 未选中是灰色加号
            model.selectColor = [UIColor whiteColor];   // 选中后为白色加号
            // 让Label上下左右全边距 稍微向上拉一点
            model.componentMargin = UIEdgeInsetsMake(-10, 0, 0, 0 );
            // 未选中状态是白色
            model.normalBackgroundColor = [UIColor whiteColor];
            // 选中为橘里橘气
            model.selectBackgroundColor = [UIColor orangeColor];
            // 设置大小/边长
            model.itemSize = CGSizeMake(40, 70); // 自动以长款中最大值进行切圆
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
    // 使用自定义的TabBar来帮助触发凸起按钮点击事件
    TfySY_TestTabBar *testTabBar = [TfySY_TestTabBar new];
    [self setValue:testTabBar forKey:@"tabBar"];
    // 5.2 设置VCs -----
    // 一定要先设置这一步，然后再进行后边的顺序，因为系统只有在setViewControllers函数后才不会再次创建UIBarButtonItem，以免造成遮挡
    // 大意就是一定要让自定义TabBar遮挡住系统的TabBar
    self.ControllerArray = tabBarVCs;
    //////////////////////////////////////////////////////////////////////////
    // 注：这里方便阅读就将AE_TabBar放在这里实例化了 使用懒加载也行
    // 6.将自定义的覆盖到原来的tabBar上面
    // 这里有两种实例化方案：
    // 6.1 使用重载构造函数方式：
    //    self.tfySY_TabBar = [[TfySY_TabBar alloc] initWithTabBarConfig:tabBarConfs];
    // 6.2 使用Set方式：
    self.tfySY_TabBar = [TfySY_TabBar new] ;
    self.tfySY_TabBar.tabBarConfig = tabBarConfs;
    // 7.设置委托
    self.tfySY_TabBar.delegate = self;
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
