//
//  TFY_ContactManagerKit.h
//  TFY_ContactManager
//
//  Created by 田风有 on 2020/9/10.
//  Copyright © 2020 田风有. All rights reserved.
//  最新版本：2.1.0

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT double TFY_ContactManagerVersionNumber;

FOUNDATION_EXPORT const unsigned char TFY_ContactManagerVersionString[];

#define TFY_ContactManagerRelease 0

#if TFY_ContactManagerRelease

#import <TFY_ContactManager/TFY_ContactManager.h>
#import <TFY_ContactManager/TFY_PersonModel.h>

#else

#import "TFY_ContactManager.h"
#import "TFY_PersonModel.h"

#endif
