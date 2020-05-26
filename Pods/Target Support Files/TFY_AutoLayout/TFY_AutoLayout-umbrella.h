#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TFY_AutoLayout.h"
#import "UITableViewCell+TFY_AutoHeightForCell.h"
#import "UIView+TFY_AutoLayout.h"
#import "UIView+TFY_Frame.h"
#import "CALayer+TFY_Frame.h"
#import "UILayoutGuide+TFY_AutoLayout.h"
#import "TFY_AutoLayoutHerder.h"

FOUNDATION_EXPORT double TFY_AutoLayoutVersionNumber;
FOUNDATION_EXPORT const unsigned char TFY_AutoLayoutVersionString[];

