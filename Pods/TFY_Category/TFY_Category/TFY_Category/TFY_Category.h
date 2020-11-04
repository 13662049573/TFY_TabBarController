//
//  TFY_Category.h
//  TFY_Category
//
//  Created by 田风有 on 2020/9/10.
//  Copyright © 2020 恋机科技. All rights reserved.
//  最新版本号:3.6.2

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT double TFY_CategoryVersionNumber;

FOUNDATION_EXPORT const unsigned char TFY_CategoryVersionString[];

#define TFY_CategoryRelease 0

#if TFY_CategoryKitRelease

#import <TFY_UI/TFY_UIHeader.h>
#import <TFY_Foundation/TFY_FoundationHeader.h>
#import <TFY_ITools/TFY_IToolsHeader.h>
#import <TFY_Category/TFY_CategoryType.h>

#else

//UI头文件
#import "TFY_UIHeader.h"
//Foundation头文件
#import "TFY_FoundationHeader.h"
//ITools头文件
#import "TFY_IToolsHeader.h"
//定义的一些宏
#import "TFY_CategoryType.h"

#endif
