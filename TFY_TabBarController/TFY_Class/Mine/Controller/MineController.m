//
//  MineController.m
//  TFY_TabarController
//
//  Created by 田风有 on 2019/6/12.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "MineController.h"
#import "MineTableViewCell.h"

@interface MineController ()
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, copy) NSArray *keys;
@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的中心展示";
    self.navigationController.tfy_titleColor = [UIColor whiteColor];
    self.navigationController.tfy_titleFont = [UIFont systemFontOfSize:15];
    self.navigationController.tfy_barBackgroundColor = [UIColor redColor];
    
    
}


@end
