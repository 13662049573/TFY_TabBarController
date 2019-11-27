//
//  TestHiddenVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "TestHiddenVC.h"

@interface TestHiddenVC ()

@end

@implementation TestHiddenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"隐藏显示tabbar";
    self.navigationController.tfy_titleColor = [UIColor whiteColor];
    self.navigationController.tfy_barBackgroundColor = [UIColor blueColor];
}

- (IBAction)click_Test:(id)sender {
    self.tabBarController.tabBar.hidden = !self.tabBarController.tabBar.hidden;
}

@end
