//
//  TFY_TabBarController.h
//  TFY_AutoLayoutModelTools
//
//  Created by 田风有 on 2019/5/14.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFY_TabContentView.h"
#import "TFY_TabBarControllerProtocol.h"

typedef NS_ENUM(NSInteger, ScenestobeusedStyle) {
    NavigationbaruseStyle,
    TabarbaruseStyle
};

NS_ASSUME_NONNULL_BEGIN

@interface TFY_TabBarController : UIViewController<TFY_TabContentViewDelegate,TFY_TabBarControllerProtocol>
/***必须要设置的属性*/
@property(nonatomic , assign)ScenestobeusedStyle  Style;
/**
 *  设置tabBar和contentView的大小
 *  默认是tabBar在底部，contentView填充其余空间
 *  如果设置了headerView，此方法不生效
 *  ScenestobeusedStyle 使用场景选择
 */
- (void)setTabBarFrame:(CGSize)tabBarSize contentViewFrame:(CGSize)contentViewSize ScenestobeusedStyle:(ScenestobeusedStyle)Style;

@end




NS_ASSUME_NONNULL_END
