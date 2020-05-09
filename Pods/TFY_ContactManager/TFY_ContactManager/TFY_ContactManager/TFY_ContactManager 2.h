//
//  TFY_ContactManager.h
//  TFY_ContactManager
//
//  Created by 田风有 on 2019/6/12.
//  Copyright © 2019 田风有. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TFY_PersonModel, TFY_SectionPerson;

/**
 * 通讯录变更回调（未分组的通讯录）
 */
typedef void (^ContactChangeHandler) (void);

@interface TFY_ContactManager : NSObject

+ (instancetype)sharedInstance;

/**
 * 通讯录变更回调
 */
@property (nonatomic, copy) ContactChangeHandler contactChangeHandler;

/**
 * 请求授权
 */
- (void)requestAddressBookAuthorization:(void (NS_NOESCAPE ^)(BOOL authorization))completion;

/**
 * 选择联系人
 * controller 控制器
 */
- (void)selectContactAtController:(UIViewController *)controller complection:(void (NS_NOESCAPE ^)(NSString *name, NSString *phone))completcion;

/**
 * 创建新联系人
 * phoneNum 手机号
 * controller 当前 Controller
 */
- (void)createNewContactWithPhoneNum:(NSString *)phoneNum controller:(UIViewController *)controller;

/**
 * 添加到现有联系人
 * phoneNum 手机号
 * controller 当前 Controller
 */
- (void)addToExistingContactsWithPhoneNum:(NSString *)phoneNum controller:(UIViewController *)controller;

/**
 * 获取联系人列表（未分组的通讯录）
 */
- (void)accessContactsComplection:(void (NS_NOESCAPE ^)(BOOL succeed, NSArray <TFY_PersonModel *> *contacts))completcion;

/**
 * 获取联系人列表（已分组的通讯录）
 */
- (void)accessSectionContactsComplection:(void (NS_NOESCAPE ^)(BOOL succeed, NSArray <TFY_SectionPerson *> *contacts, NSArray <NSString *> *keys))completcion;

@end

NS_ASSUME_NONNULL_END
