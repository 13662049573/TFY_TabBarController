//
//  UIViewController+TFY_PopController.h
//  TFY_Navigation
//
//  Created by 田风有 on 2019/11/2.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFY_PopController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TFY_PopController)
/**
 * pop size for portrait orientation.
 */
@property (nonatomic, assign) IBInspectable CGSize contentSizeInPop;
/**
 * pop size for landscape orientation
 */
@property (nonatomic, assign) IBInspectable CGSize contentSizeInPopWhenLandscape;

/**
 * The pop ViewController referred HWPopController
 */
@property (nullable, nonatomic, weak, readonly) TFY_PopController *popController;

@end

@interface UIViewController (Pop)

/**
 * 将弹出的控制器调用此方法弹出。
 */
- (TFY_PopController *)popup;

- (TFY_PopController *)popupWithPopType:(PopType)popType dismissType:(DismissType)dismissType;

- (TFY_PopController *)popupWithPopType:(PopType)popType dismissType:(DismissType)dismissType position:(PopPosition)popPosition;

- (TFY_PopController *)popupWithPopType:(PopType)popType dismissType:(DismissType)dismissType position:(PopPosition)popPosition dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch;

- (TFY_PopController *)popupWithPopType:(PopType)popType dismissType:(DismissType)dismissType position:(PopPosition)popPosition inViewController:(UIViewController *)inViewController dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch;
@end

NS_ASSUME_NONNULL_END
