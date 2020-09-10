//
//  AppDelegate.m
//  TFY_TabBarController
//
//  Created by tiandengyou on 2019/11/27.
//  Copyright © 2019 田风有. All rights reserved.
//

#import "AppDelegate.h"
#import "PushHiddenTabBarVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (![ScenePackage defaultPackage].isSceneApp) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    }
    [[ScenePackage defaultPackage] addBeforeWindowEvent:^(ScenePackage * _Nonnull application) {
        [UIApplication window].rootViewController = [PushHiddenTabBarVC new];
    }];
    return YES;
}



@end
