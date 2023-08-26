//
//  WeiBoTabBarVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "WeiBoTabBarVC.h"
@interface WeiBoTabBarVC ()<TfySY_ControllerDelegate>

@end

@implementation WeiBoTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子VC
    [self addChildViewControllers];
    
    self.vc_delegate = self;
}
- (void)addChildViewControllers{
    // 创建选项卡的数据 想怎么写看自己，这块我就写笨点了
    
    NSArray <NSDictionary *>*VCArray =
    @[@{@"normalImg":@"WeiBo",@"selectImg":@"WeiBo_",@"itemTitle":@"微博"},
      @{@"normalImg":@"Msg",@"selectImg":@"Msg_",@"itemTitle":@"消息"},
      @{@"normalImg":@"",@"selectImg":@"",@"itemTitle":@" "},
      @{@"normalImg":@"Find",@"selectImg":@"Find_",@"itemTitle":@"发现"},
      @{@"normalImg":@"Me",@"selectImg":@"Me_",@"itemTitle":@"我"}];
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
        model.selectColor = [UIColor blackColor];
        model.normalColor = [UIColor blackColor];

        /***********************************/
        if (idx == 2 ) { // 如果是中间的
            // 设置凸出
            model.bulgeStyle = TfySY_TabBarConfigBulgeStyleSquare;
            // 设置凸出高度
            model.bulgeHeight = -5;
            model.bulgeRoundedCorners = 2; // 修角
            // 设置成纯文字展示
            model.itemLayoutStyle = TfySY_TabBarItemLayoutStyleTitle;
            // 文字为加号
            model.itemTitle = @"+";
            // 字号大小
            model.titleLabel.font = [UIFont systemFontOfSize:40];
            model.normalColor = [UIColor whiteColor]; // 未选中
            model.selectColor = [UIColor whiteColor];   // 选中后一致
            // 让Label上下左右全边距
            model.componentMargin = UIEdgeInsetsMake(-5, 0, 0, 0 );
            // 未选中选中为橘里橘气
            model.normalBackgroundColor = [UIColor orangeColor];
            model.selectBackgroundColor = [UIColor orangeColor];
            // 设置大小/边长
            model.itemSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 35.0 ,self.tabBar.frame.size.height - 10);
        }
        // 备注 如果一步设置的VC的背景颜色，VC就会提前绘制驻留，优化这方面的话最好不要这么写
        // 示例中为了方便就在这写了

        // 5.1添加构造Model到集合
        [tabBarConfs addObject:model];
    }];
    // 5.2 设置VCs -----
    // 一定要先设置这一步，然后再进行后边的顺序，因为系统只有在setViewControllers函数后才不会再次创建UIBarButtonItem，以免造成遮挡
    // 大意就是一定要让自定义TabBar遮挡住系统的TabBar
    for (NSInteger i=0; i<4; i++) {
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f
                                                  green:arc4random()%255/255.f
                                                   blue:arc4random()%255/255.f alpha:1];
        
        // 5.将VC添加到系统控制组
        [tabBarVCs addObject:vc];
    }
    
    [self controllerArr:tabBarVCs TabBarConfigModelArr:tabBarConfs];
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
