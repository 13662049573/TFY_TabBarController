//
//  CalendarController.m
//  TFY_TabarController
//
//  Created by 田风有 on 2019/11/23.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "CalendarController.h"

@interface CalendarController ()

@end

@implementation CalendarController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:true animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
}



@end
