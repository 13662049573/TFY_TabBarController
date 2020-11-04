//
//  NSMutableArray+TFY_Array.h
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/20.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (TFY_Array)
/**
 *  将属性列表数据转换为 NSMutableArray 返回。
 */
+ (nullable NSMutableArray *)tfy_arrayWithPlistData:(NSData *)plist;

/**
 *  将xml格式的属性列表字符串转换为 NSMutableArray 返回。
 */
+ (nullable NSMutableArray *)tfy_arrayWithPlistString:(NSString *)plist;

/**
 *  移除数组里第一个元素，如果数组为空则不操作。
 */
- (void)tfy_removeFirstObject;

/**
 *  移除数组里最后一个元素，如果数组为空则不操作。
 */
- (void)tfy_removeLastObject;

/**
 *  移除数组里第一个元素，并返回这个元素，如果数组为空则不操作。
 */
- (nullable id)tfy_popFirstObject;

/**
 *  移除数组里最后一个元素，并返回这个元素，如果数组为空则不操作。
 */
- (nullable id)tfy_popLastObject;

/**
 *  添加一个元素到数组末端。
 */
- (void)tfy_appendObject:(id)anObject;

/**
 *  插入一个元素到数组首端。
 */
- (void)tfy_prependObject:(id)anObject;

/**
 *  将数组 objects 里的所有元素按 objects 里的顺序添加到数组末端。
 */
- (void)tfy_appendObjects:(NSArray *)objects;

/**
 *  将数组 objects 里的所有元素按 objects 里的顺序添加到数组首端。
 */
- (void)tfy_prependObjects:(NSArray *)objects;

/**
 *  将数组 objects 里的所有元素按 objects 里的顺序添加到数组 index 位置，index 不能大于数组元素的个数。
 */
- (void)tfy_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

/**
 *  逆序数组元素。
 */
- (void)tfy_reverse;

/**
 *  将数组里的元素随机排序。
 */
- (void)tfy_shuffle;

@end

NS_ASSUME_NONNULL_END
