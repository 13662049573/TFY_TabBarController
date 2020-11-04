//
//  NSMutableArray+TFY_Array.m
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/20.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "NSMutableArray+TFY_Array.h"

@implementation NSMutableArray (TFY_Array)
+ (NSMutableArray *)tfy_arrayWithPlistData:(NSData *)plist {
    if (!plist) return nil;
    NSMutableArray *array = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    if ([array isKindOfClass:[NSMutableArray class]]) return array;
    return nil;
}

+ (NSMutableArray *)tfy_arrayWithPlistString:(NSString *)plist {
    if (!plist) return nil;
    NSData *data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self tfy_arrayWithPlistData:data];
}

- (void)tfy_removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)tfy_removeLastObject {
    if (self.count) {
        [self removeObjectAtIndex:self.count - 1];
    }
}

#pragma clang diagnostic pop


- (id)tfy_popFirstObject {
    id obj = nil;
    if (self.count) {
        obj = self.firstObject;
        [self tfy_removeFirstObject];
    }
    return obj;
}

- (id)tfy_popLastObject {
    id obj = nil;
    if (self.count) {
        obj = self.lastObject;
        [self removeLastObject];
    }
    return obj;
}

- (void)tfy_appendObject:(id)anObject {
    [self addObject:anObject];
}

- (void)tfy_prependObject:(id)anObject {
    [self insertObject:anObject atIndex:0];
}

- (void)tfy_appendObjects:(NSArray *)objects {
    if (!objects) return;
    [self addObjectsFromArray:objects];
}

- (void)tfy_prependObjects:(NSArray *)objects {
    if (!objects) return;
    NSUInteger i = 0;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)tfy_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    NSUInteger i = index;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)tfy_reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)tfy_shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}

@end
