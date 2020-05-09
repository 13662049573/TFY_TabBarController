//
//  NSString+TFY_Extension.h
//  TFY_ContactManager
//
//  Created by 田风有 on 2019/6/12.
//  Copyright © 2019 田风有. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TFY_Extension)
/**
 * 去除手机号的特殊字段
 * string 手机号
 */
+ (NSString *)tfy_filterSpecialString:(NSString *)string;

/**
 * 字符串转拼音
 * string 字符串
 */
+ (NSString *)tfy_pinyinForString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
