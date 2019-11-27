//
//  HomeController.m
//  TFY_TabarController
//
//  Created by 田风有 on 2019/6/12.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "HomeController.h"
#import "HomeTableViewCell.h"

@interface HomeController ()
@property (nonatomic, copy) NSArray *dataSource;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页展示";
    
    self.navigationController.tfy_barBackgroundColor = [UIColor orangeColor];
    

}


@end
