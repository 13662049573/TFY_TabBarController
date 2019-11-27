//
//  UIScrollView+TFY_Chain.h
//  TFY_Category
//
//  Created by tiandengyou on 2019/11/4.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (TFY_Chain)

- (void )screenSnapshot:(void(^)(UIImage *snapShotImage))finishBlock;

+(UIImage *)screenSnapshotWithSnapshotView:(UIView *)snapshotView;

+(UIImage *)screenSnapshotWithSnapshotView:(UIView *)snapshotView snapshotSize:(CGSize )snapshotSize;
@end

NS_ASSUME_NONNULL_END
