//
//  RootViewController.m
//  TFY_TabarController
//
//  Created by 田风有 on 2019/11/23.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *btn = tfy_button();
    btn.tfy_title(@"返回", @"FFFFFF", 1).tfy_font(18).tfy_backgroundColor(@"FF546E", 1).tfy_cornerRadius(30).tfy_action(self, @selector(popoverControllerClick:));
    [self.view addSubview:btn];
    btn.tfy_LeftSpace(40).tfy_CenterY(0).tfy_RightSpace(40).tfy_Height(60);
}

-(void)popoverControllerClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
