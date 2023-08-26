//
//  TfySY_TabBarController.h
//  TFY_TabarController
//
//  Created by tiandengyou on 2019/11/25.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TfySY_TabBar.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TfySY_ControllerDelegate <NSObject>
@optional
// 点击事件
- (void)TfySY_TabBar:(TfySY_TabBar *)tabbar newsVc:(UIViewController *)vc selectIndex:(NSInteger)index;

//双击事件
- (void)TfySY_TabBarDoubleClick:(TfySY_TabBar *)tabbar newsVc:(UIViewController *)vc selectIndex:(NSInteger)index;

/**重新布局或者添加需要的东西需要横竖适配调用次方法*/
-(void)tfySY_LayoutSubviews;

@end

@interface TfySY_TabBarController : UITabBarController
/**模型容器*/
@property (nonatomic, strong) TfySY_TabBar *tfySY_TabBar;
/**控制器代理*/
@property (nonatomic, weak) id <TfySY_ControllerDelegate>vc_delegate;

- (void)controllerArr:(NSArray<UIViewController*>*)vcArr TabBarConfigModelArr:(NSArray<TfySY_TabBarConfigModel *>*)tabBarConfigArr;

@end

NS_ASSUME_NONNULL_END
