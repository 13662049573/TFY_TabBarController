//
//  TestVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"进入界面隐藏tabbar";
    self.navigationController.tfy_titleColor = [UIColor redColor];
    self.navigationController.tfy_barBackgroundColor = [UIColor yellowColor];
}
- (IBAction)click_Test:(id)sender {
    TestVC *vc = [TestVC new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
