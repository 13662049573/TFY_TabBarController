//
//  NSObject+TFY_Add.m
//  TFY_Navigation
//
//  Created by 田风有 on 2019/11/2.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "NSObject+TFY_Add.h"
#import <objc/runtime.h>

@implementation NSObject (TFY_Add)

+ (BOOL)tfy_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;

    class_addMethod(self,
            originalSel,
            class_getMethodImplementation(self, originalSel),
            method_getTypeEncoding(originalMethod));
    class_addMethod(self,
            newSel,
            class_getMethodImplementation(self, newSel),
            method_getTypeEncoding(newMethod));

    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
            class_getInstanceMethod(self, newSel));
    return YES;
}

+ (BOOL)tfy_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel {
    Class class = object_getClass(self);
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    return YES;
}

@end
