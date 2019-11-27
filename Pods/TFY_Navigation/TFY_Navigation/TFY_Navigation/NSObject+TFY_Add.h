//
//  NSObject+TFY_Add.h
//  TFY_Navigation
//
//  Created by 田风有 on 2019/11/2.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (TFY_Add)
+ (BOOL)tfy_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)tfy_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;
@end

NS_ASSUME_NONNULL_END
