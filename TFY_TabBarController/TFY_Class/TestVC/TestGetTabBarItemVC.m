//
//  TestGetTabBarItemVC.m
//  TfySY_TabBar
//
//  Created by Axc on 2018/6/4.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "TestGetTabBarItemVC.h"
#import "TfySY_TabBarController.h"

@interface TestGetTabBarItemVC ()
;
@property(nonatomic, assign)NSInteger badge;
@end

@implementation TestGetTabBarItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加微标";
   
}
- (IBAction)click:(id)sender {
    TfySY_TabBarController *tabBarVC = (TfySY_TabBarController *)self.tabBarController;
    TfySY_TabBarItem *item = tabBarVC.tfySY_TabBar.currentSelectItem; // 因为已经到这个页面，说明就是当前的选项卡item
    self.badge +=10;
    item.badge = [NSString stringWithFormat:@"%ld",(long)self.badge];
}


@end
