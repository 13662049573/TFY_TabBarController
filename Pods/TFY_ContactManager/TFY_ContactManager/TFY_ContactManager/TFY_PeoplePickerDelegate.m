//
//  TFY_PeoplePickerDelegate.m
//  TFY_ContactManager
//
//  Created by 田风有 on 2019/6/12.
//  Copyright © 2019 田风有. All rights reserved.
//

#import "TFY_PeoplePickerDelegate.h"

@implementation TFY_PeoplePickerDelegate

#pragma mark - CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact;
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self addToExistingContactsWithPhoneNum:self.phoneNum contact:contact controller:self.controller];
    }];
}

#pragma mark - CNContactViewControllerDelegate

- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(CNContact *)contact
{
    if (self.completcion)
    {
        self.completcion(YES);
    }
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker
{
    if (self.completcion)
    {
        self.completcion(NO);
    }
}

- (void)addToExistingContactsWithPhoneNum:(NSString *)phoneNum
                                   contact:(CNContact *)contact
                                controller:(UIViewController *)controller
{
    CNMutableContact *mutableContact = [contact mutableCopy];
    
    CNLabeledValue *phoneNumber = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberMobile
                                                                  value:[CNPhoneNumber phoneNumberWithStringValue:phoneNum]];
    
    if (mutableContact.phoneNumbers.count > 0)
    {
        NSMutableArray *phoneNumbers = [mutableContact.phoneNumbers mutableCopy];
        [phoneNumbers addObject:phoneNumber];
        mutableContact.phoneNumbers = phoneNumbers;
    }
    else
    {
        mutableContact.phoneNumbers = @[phoneNumber];
    }
    
    CNContactViewController *contactController = [CNContactViewController viewControllerForNewContact:mutableContact];
    contactController.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:contactController];
    [controller presentViewController:nav animated:YES completion:nil];
}
@end
