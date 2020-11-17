//
//  TFY_TabBarKit.h
//  TFY_TabBarController
//
//  Created by 田风有 on 2020/9/10.
//  Copyright © 2020 田风有. All rights reserved.
//  最新版本号:1.1.6

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double TFY_TabBarKitVersionNumber;

FOUNDATION_EXPORT const unsigned char TFY_TabBarKitVersionString[];

#define TFY_TabBarKitRelease 0

#if TFY_TabBarKitRelease

#import <TFY_SystemTabBar/TfySY_TabBarController.h>
#import <TFY_SystemTabBar/TfySY_TestTabBar.h>

#else

#import "TfySY_TabBarController.h"
#import "TfySY_TestTabBar.h"

#endif
