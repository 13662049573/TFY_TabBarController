//
//  CommonPageViewController.h
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/10.
//  Copyright © 2019 xianliang meng. All rights reserved.
//  基础功能展示

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonPageViewController : UIViewController
//标题组
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, assign)NSInteger index;
@end

NS_ASSUME_NONNULL_END
