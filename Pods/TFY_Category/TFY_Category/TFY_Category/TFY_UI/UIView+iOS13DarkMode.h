//
//  UIView+iOS13DarkMode.h
//  TFY_Category
//
//  Created by 田风有 on 2020/11/2.
//  Copyright © 2020 恋机科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (iOS13DarkMode)
- (void(^)(UIColor *color))tfy_iOS13BorderColor;

- (void(^)(UIColor *color))tfy_iOS13ShadowColor;

- (void(^)(UIColor *color))tfy_iOS13BackgroundColor;
@end

NS_ASSUME_NONNULL_END
