//
//  TFY_PickerDetailDelegate.h
//  TFY_ContactManager
//
//  Created by 田风有 on 2019/6/12.
//  Copyright © 2019 田风有. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ContactsUI/ContactsUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PickerDetailDelegate : NSObject<CNContactPickerDelegate>

@property (nonatomic, copy) void (^handler) (NSString *name, NSString *phoneNum);

@end

NS_ASSUME_NONNULL_END
