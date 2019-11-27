//
//  UIViewController+TFY_Tab.h
//  TFY_TabBarKit
//
//  Created by 田风有 on 2019/11/25.
//  Copyright © 2019 田风有. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFY_TabBarItem.h"
#import "TFY_TabBar.h"
#import "TFY_TabBarControllerProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@class TFY_TabBarItem;

@interface UIViewController (TFY_Tab)
/**
 * 当添加到选项卡栏控制器时表示视图控制器的选项卡栏项。
 */
@property(nonatomic, strong, readonly) TFY_TabBarItem *tfy_tabItem;
@property (nonatomic, strong, readonly) id<TFY_TabBarControllerProtocol> tfy_tabBarController;

@property (nonatomic, copy) NSString *tfy_tabItemTitle; // tabItem的标题
@property (nonatomic, strong) UIImage *tfy_tabItemImage; // tabItem的图像
@property (nonatomic, strong) UIImage *tfy_tabItemSelectedImage; // tabItem的选中图像
/**
 *  ViewController对应的Tab被Select后，执行此方法，此方法为回调方法
 *  isFirstTime  是否为第一次被选中
 */
- (void)tfy_tabItemDidSelected:(BOOL)isFirstTime;

/**
 *  ViewController对应的Tab被Deselect后，执行此方法，此方法为回调方法
 */
- (void)tfy_tabItemDidDeselected;

/**
 *  返回用于显示的View，默认是self.view
 *  当设置headerView的时候，需要把scrollView或者tableView返回
 */
- (UIScrollView *)tfy_scrollView;
@end

NS_ASSUME_NONNULL_END
