//
//  TFY_ContactManager.m
//  TFY_ContactManager
//
//  Created by 田风有 on 2019/6/12.
//  Copyright © 2019 田风有. All rights reserved.
//

#import "TFY_ContactManager.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

#import "TFY_PeoplePickerDelegate.h"
#import "TFY_PickerDetailDelegate.h"
#import "TFY_PersonModel.h"
#import "NSString+TFY_Extension.h"

#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

@interface TFY_ContactManager ()<CNContactViewControllerDelegate, CNContactPickerDelegate>

@property (nonatomic, copy) void (^handler) (NSString *, NSString *);
@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, copy) NSArray *keys;
@property (nonatomic, strong) TFY_PeoplePickerDelegate *pickerDelegate;
@property (nonatomic, strong) TFY_PickerDetailDelegate *pickerDetailDelegate;
@property (nonatomic, strong) CNContactStore *contactStore;
@property (nonatomic) dispatch_queue_t queue;

@end


@implementation TFY_ContactManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _queue = dispatch_queue_create("com.addressBook.queue", DISPATCH_QUEUE_SERIAL);
        
        if (IOS9_OR_LATER)
        {
            _contactStore = [CNContactStore new];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(_contactStoreDidChange)
                                                         name:CNContactStoreDidChangeNotification
                                                       object:nil];
        }
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static id shared_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared_instance = [[self alloc] init];
    });
    return shared_instance;
}

- (NSArray *)keys
{
    if (!_keys)
    {
        _keys = @[[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],
                  CNContactPhoneNumbersKey,
                  CNContactOrganizationNameKey,
                  CNContactDepartmentNameKey,
                  CNContactJobTitleKey,
                  CNContactNoteKey,
                  CNContactPhoneticGivenNameKey,
                  CNContactPhoneticFamilyNameKey,
                  CNContactPhoneticMiddleNameKey,
                  CNContactImageDataKey,
                  CNContactThumbnailImageDataKey,
                  CNContactEmailAddressesKey,
                  CNContactPostalAddressesKey,
                  CNContactBirthdayKey,
                  CNContactNonGregorianBirthdayKey,
                  CNContactInstantMessageAddressesKey,
                  CNContactSocialProfilesKey,
                  CNContactRelationsKey,
                  CNContactUrlAddressesKey];
        
    }
    return _keys;
}

- (TFY_PeoplePickerDelegate *)pickerDelegate
{
    if (!_pickerDelegate)
    {
        _pickerDelegate = [TFY_PeoplePickerDelegate new];
    }
    return _pickerDelegate;
}

- (TFY_PickerDetailDelegate *)pickerDetailDelegate
{
    if (!_pickerDetailDelegate)
    {
        _pickerDetailDelegate = [TFY_PickerDetailDelegate new];
        __weak typeof(self) weakSelf = self;
        _pickerDetailDelegate.handler = ^(NSString *name, NSString *phoneNum) {
            NSString *newPhoneNum = [NSString tfy_filterSpecialString:phoneNum];
            weakSelf.handler(name, newPhoneNum);
        };
    }
    return _pickerDetailDelegate;
}

#pragma mark - Public

- (void)selectContactAtController:(UIViewController *)controller complection:(void (NS_NOESCAPE ^)(NSString *, NSString *))completcion{
    
    self.isAdd = NO;
    [self presentFromController:controller];
    
    self.handler = completcion;
}

- (void)createNewContactWithPhoneNum:(NSString *)phoneNum controller:(UIViewController *)controller
{
    if (IOS9_OR_LATER)
    {
        CNMutableContact *contact = [[CNMutableContact alloc] init];
        CNLabeledValue *labelValue = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberMobile
                                                                     value:[CNPhoneNumber phoneNumberWithStringValue:phoneNum]];
        contact.phoneNumbers = @[labelValue];
        CNContactViewController *contactController = [CNContactViewController viewControllerForNewContact:contact];
        contactController.delegate = self;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:contactController];
        [controller presentViewController:nav animated:YES completion:nil];
    }
}

- (void)addToExistingContactsWithPhoneNum:(NSString *)phoneNum controller:(UIViewController *)controller
{
    self.isAdd = YES;
    self.pickerDelegate.phoneNum = phoneNum;
    self.pickerDelegate.controller = controller;
    
    [self presentFromController:controller];
}

- (void)accessContactsComplection:(void (NS_NOESCAPE ^)(BOOL, NSArray<TFY_PersonModel *> *))completcion
{
    [self requestAddressBookAuthorization:^(BOOL authorization) {
        
        if (authorization)
        {
            if (IOS9_OR_LATER)
            {
                [self asynAccessContactStoreWithSort:NO completcion:^(NSArray *datas, NSArray *keys) {
                    
                    if (completcion)
                    {
                        completcion(YES, datas);
                    }
                }];
            }
        }
        else
        {
            if (completcion)
            {
                completcion(NO, nil);
            }
        }
    }];
}

- (void)accessSectionContactsComplection:(void (NS_NOESCAPE ^)(BOOL, NSArray<TFY_SectionPerson *> *, NSArray<NSString *> *))completcion
{
    [self requestAddressBookAuthorization:^(BOOL authorization) {
        
        if (authorization)
        {
            if (IOS9_OR_LATER)
            {
                [self asynAccessContactStoreWithSort:YES completcion:^(NSArray *datas, NSArray *keys) {
                    
                    if (completcion)
                    {
                        completcion(YES, datas, keys);
                    }
                }];
            }
        }
        else
        {
            if (completcion)
            {
                completcion(NO, nil, nil);
            }
        }
    }];
}

#pragma mark - CNContactViewControllerDelegate

- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(nullable CNContact *)contact
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)requestAddressBookAuthorization:(void (NS_NOESCAPE ^)(BOOL authorization))completion
{
    if (IOS9_OR_LATER)
    {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        
        if (status == CNAuthorizationStatusNotDetermined)
        {
            [self authorizationAddressBook:^(BOOL succeed) {
                blockExecute(completion, succeed);
            }];
        }
        else
        {
            blockExecute(completion, status == CNAuthorizationStatusAuthorized);
        }
    }
}

#pragma mark - Private

- (void)authorizationAddressBook:(void (^) (BOOL succeed))completion
{
    if (IOS9_OR_LATER)
    {
        [_contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (completion)
            {
                completion(granted);
            }
        }];
    }
}

void blockExecute(void (^completion)(BOOL authorizationA), BOOL authorizationB)
{
    if (completion)
    {
        if ([NSThread isMainThread])
        {
            completion(authorizationB);
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(authorizationB);
            });
        }
    }
}

- (void)presentFromController:(UIViewController *)controller
{
    if (IOS9_OR_LATER)
    {
        CNContactPickerViewController *pc = [[CNContactPickerViewController alloc] init];
        if (self.isAdd)
        {
            pc.delegate = self.pickerDelegate;
        }
        else
        {
            pc.delegate = self.pickerDetailDelegate;
        }
        
        pc.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        
        [self requestAddressBookAuthorization:^(BOOL authorization) {
            if (authorization)
            {
                [controller presentViewController:pc animated:YES completion:nil];
            }
            else
            {
                [self showAlertFromController:controller];
            }
        }];
    }
}

- (void)showAlertFromController:(UIViewController *)controller
{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的通讯录暂未允许访问，请去设置->隐私里面授权!" preferredStyle:UIAlertControllerStyleAlert];
    [alertControl addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }])];
    [alertControl addAction:([UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{}
                                         completionHandler:^(BOOL success) {
                                         }];
            } else {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }])];
    [controller presentViewController:alertControl animated:YES completion:nil];
}

- (void)asynAccessContactStoreWithSort:(BOOL)isSort completcion:(void (NS_NOESCAPE ^)(NSArray *, NSArray *))completcion
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(_queue, ^{
        
        NSMutableArray *datas = [NSMutableArray array];
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:self.keys];
        [weakSelf.contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            
            TFY_PersonModel *person = [[TFY_PersonModel alloc] initWithCNContact:contact];
            [datas addObject:person];
            
        }];
        
        if (!isSort)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (completcion)
                {
                    completcion(datas, nil);
                }
                
            });
            
            return;
        }
        
        [self sortNameWithDatas:datas completcion:^(NSArray *persons, NSArray *keys) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (completcion)
                {
                    completcion(persons, keys);
                }
                
            });
            
        }];
        
    });
}

- (void)sortNameWithDatas:(NSArray *)datas completcion:(void (NS_NOESCAPE ^)(NSArray *, NSArray *))completcion
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (TFY_PersonModel *person in datas)
    {
        // 拼音首字母
        NSString *firstLetter = nil;
        
        if (person.fullName.length == 0)
        {
            firstLetter = @"#";
        }
        else
        {
            NSString *pinyinString = [NSString tfy_pinyinForString:person.fullName];
            person.pinyin = pinyinString;
            NSString *upperStr = [[pinyinString substringToIndex:1] uppercaseString];
            NSString *regex = @"^[A-Z]$";
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            firstLetter = [predicate evaluateWithObject:upperStr] ? upperStr : @"#";
        }
        
        if (dict[firstLetter])
        {
            [dict[firstLetter] addObject:person];
        }
        else
        {
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:person, nil];
            dict[firstLetter] = arr;
        }
    }
    
    NSMutableArray *keys = [[[dict allKeys] sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    
    if ([keys.firstObject isEqualToString:@"#"])
    {
        [keys addObject:keys.firstObject];
        [keys removeObjectAtIndex:0];
    }
    
    NSMutableArray *persons = [NSMutableArray array];
    
    [keys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TFY_SectionPerson *person = [TFY_SectionPerson new];
        person.key = key;
        
        // 组内按照拼音排序
        NSArray *personsArr = [dict[key] sortedArrayUsingComparator:^NSComparisonResult(TFY_PersonModel *person1, TFY_PersonModel *person2) {
            
            NSComparisonResult result = [person1.pinyin compare:person2.pinyin];
            return result;
        }];
        
        person.persons = personsArr;
        
        [persons addObject:person];
    }];
    
    if (completcion)
    {
        completcion(persons, keys);
    }
}


- (void)_contactStoreDidChange
{
    if ([TFY_ContactManager sharedInstance].contactChangeHandler)
    {
        [TFY_ContactManager sharedInstance].contactChangeHandler();
    }
}

- (void)dealloc
{
    if (IOS9_OR_LATER)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:CNContactStoreDidChangeNotification object:nil];
    }
}

@end
