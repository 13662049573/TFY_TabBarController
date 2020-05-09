//
//  TFY_PeoplePickerDelegate.h
//  TFY_ContactManager
//
//  Created by 田风有 on 2019/6/12.
//  Copyright © 2019 田风有. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ContactsUI/ContactsUI.h>
NS_ASSUME_NONNULL_BEGIN

@interface TFY_PeoplePickerDelegate : NSObject<CNContactPickerDelegate, CNContactViewControllerDelegate>
@property (nonatomic, copy) NSString *phoneNum;
@property (nonatomic, weak) UIViewController *controller;
@property (nonatomic, copy) void (^completcion) (BOOL succeed);
@end

NS_ASSUME_NONNULL_END
