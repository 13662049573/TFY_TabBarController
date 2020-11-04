//
//  TFY_IOS13DarkMode.h
//  TFY_Category
//
//  Created by 田风有 on 2020/11/2.
//  Copyright © 2020 恋机科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TFY_IOS13DarkMode_MonitorView_TraitCollectionCallback)(UIView *view);

@interface TFY_IOS13DarkMode : UIView

- (void)setTraitCollectionChange:(TFY_IOS13DarkMode_MonitorView_TraitCollectionCallback __nullable)callback forKey:(NSString *)key forObject:(id)object;

@end

NS_ASSUME_NONNULL_END
