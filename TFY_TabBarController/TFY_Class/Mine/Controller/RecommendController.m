//
//  RecommendController.m
//  TFY_TabarController
//
//  Created by 田风有 on 2019/11/23.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "RecommendController.h"
#import "RootViewController.h"
@interface RecommendController ()

@end

@implementation RecommendController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:true animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = tfy_button();
    btn.tfy_title(@"点击将进入",UIControlStateNormal, @"FFFFFF",UIControlStateNormal, [UIFont systemFontOfSize:18]).tfy_backgroundColor(@"FF546E", 1).tfy_cornerRadius(30).tfy_action(self, @selector(popoverControllerClick:),UIControlEventTouchUpInside);
    [self.view addSubview:btn];
    btn.tfy_LeftSpace(40).tfy_CenterY(0).tfy_RightSpace(40).tfy_Height(60);
}

-(void)popoverControllerClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    RootViewController *vc = [RootViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
