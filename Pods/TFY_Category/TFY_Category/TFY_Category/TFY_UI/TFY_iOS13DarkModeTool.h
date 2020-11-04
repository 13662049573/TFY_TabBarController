//
//  TFY_iOS13DarkModeTool.h
//  TFY_Category
//
//  Created by 田风有 on 2020/11/2.
//  Copyright © 2020 恋机科技. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const char * TFY_iOS13DarkMode_LightColor_Key;
extern const char * TFY_iOS13DarkMode_DarkColor_Key;

extern const char * TFY_iOS13DarkMode_LayerBorderColor_Key;
extern const char * TFY_iOS13DarkMode_LayerShadowColor_Key;
extern const char * TFY_iOS13DarkMode_LayerBackgroundColor_Key;

NS_ASSUME_NONNULL_BEGIN

@interface TFY_iOS13DarkModeTool : NSObject

+ (void)tfy_ExchangeClassMethodWithTargetCls:(Class)targetCls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

+ (void)tfy_ExchangeMethodWithOriginalClass:(Class)originalClass swizzledClass:(Class)swizzledClass originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
@end

NS_ASSUME_NONNULL_END
