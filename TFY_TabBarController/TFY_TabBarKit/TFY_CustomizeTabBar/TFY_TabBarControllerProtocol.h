//
//  TFY_TabBarControllerProtocol.h
//  TFY_TabarController
//
//  Created by 田风有 on 2019/11/23.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class TFY_TabBar;
@class TFY_TabContentView;

@protocol TFY_TabBarControllerProtocol <NSObject>

@property (nonatomic, strong, readonly) TFY_TabBar *tabBar;

@property (nonatomic, strong, readonly) TFY_TabContentView *tabContentView;

@property (nonatomic, copy) NSArray <UIViewController *> *viewControllers;

@end
