//
//  TestPushHiddenVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "TestPushHiddenVC.h"
#import "TestVC.h"
@interface TestPushHiddenVC ()

@end

@implementation TestPushHiddenVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"asd";
}

- (IBAction)click_Test:(id)sender {
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:[TestVC new] animated:YES];
}
@end
