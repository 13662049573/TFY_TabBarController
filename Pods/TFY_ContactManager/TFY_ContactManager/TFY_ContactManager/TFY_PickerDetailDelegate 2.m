//
//  TFY_PickerDetailDelegate.m
//  TFY_ContactManager
//
//  Created by 田风有 on 2019/6/12.
//  Copyright © 2019 田风有. All rights reserved.
//

#import "TFY_PickerDetailDelegate.h"

@implementation TFY_PickerDetailDelegate

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
    CNContact *contact = contactProperty.contact;
    
    NSString *name = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
    CNPhoneNumber *phoneValue= contactProperty.value;
    if ([phoneValue isKindOfClass:[CNPhoneNumber class]])
    {
        if (self.handler)
        {
            self.handler(name, phoneValue.stringValue);
        }
    }
    else
    {
        // 邮箱
        if (self.handler)
        {
            self.handler(name, (NSString *)phoneValue);
        }
    }
}

@end
