//
//  TFY_TabBarHeader.h
//  TFY_TabarController
//
//  Created by 田风有 on 2019/5/23.
//  Copyright © 2019 恋机科技. All rights reserved.
//  最新版本号:1.0.8

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define TFY_AutoLayoutKitRelease 0

#if TFY_AutoLayoutKitRelease
//系统自带
#import <TFY_SystemTabBar/TfySY_TabBarController.h>
#import <TFY_SystemTabBar/TfySY_TestTabBar.h>

#else

//系统自带
#import "TfySY_TabBarController.h"
#import "TfySY_TestTabBar.h"

#endif

