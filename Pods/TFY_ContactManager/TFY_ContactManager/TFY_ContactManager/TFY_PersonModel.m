//
//  TFY_PersonModel.m
//  TFY_ContactManager
//
//  Created by 田风有 on 2019/6/12.
//  Copyright © 2019 田风有. All rights reserved.
//

#import "TFY_PersonModel.h"
#import "NSString+TFY_Extension.h"

@implementation TFY_PersonModel

- (instancetype)initWithCNContact:(CNContact *)contact
{
    self = [super init];
    if (self)
    {
        self.contactType = contact.contactType == CNContactTypePerson ? ContactTypePerson : ContactTypeOrigination;
        
        self.fullName = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
        self.familyName = contact.familyName;
        self.givenName = contact.givenName;
        self.nameSuffix = contact.nameSuffix;
        self.namePrefix = contact.namePrefix;
        self.nickname = contact.nickname;
        self.middleName = contact.middleName;
        
        if ([contact isKeyAvailable:CNContactOrganizationNameKey])
        {
            self.organizationName = contact.organizationName;
        }
        
        if ([contact isKeyAvailable:CNContactDepartmentNameKey])
        {
            self.departmentName = contact.departmentName;
        }
        
        if ([contact isKeyAvailable:CNContactJobTitleKey])
        {
            self.jobTitle = contact.jobTitle;
        }
        
        if ([contact isKeyAvailable:CNContactNoteKey])
        {
            self.note = contact.note;
        }
        
        if ([contact isKeyAvailable:CNContactPhoneticFamilyNameKey])
        {
            self.phoneticFamilyName = contact.phoneticFamilyName;
        }
        if ([contact isKeyAvailable:CNContactPhoneticGivenNameKey])
        {
            self.phoneticGivenName = contact.phoneticGivenName;
        }
        
        if ([contact isKeyAvailable:CNContactPhoneticMiddleNameKey])
        {
            self.phoneticMiddleName = contact.phoneticMiddleName;
        }
        
        if ([contact isKeyAvailable:CNContactImageDataKey])
        {
            self.imageData = contact.imageData;
            self.image = [UIImage imageWithData:contact.imageData];
        }
        
        if ([contact isKeyAvailable:CNContactThumbnailImageDataKey])
        {
            self.thumbnailImageData = contact.thumbnailImageData;
            self.thumbnailImage = [UIImage imageWithData:contact.thumbnailImageData];
        }
        
        if ([contact isKeyAvailable:CNContactPhoneNumbersKey])
        {
            // 号码
            NSMutableArray *phones = [NSMutableArray array];
            for (CNLabeledValue *labeledValue in contact.phoneNumbers)
            {
                TFY_Phone *phoneModel = [[TFY_Phone alloc] initWithLabeledValue:labeledValue];
                [phones addObject:phoneModel];
            }
            self.phones = phones;
        }
        
        if ([contact isKeyAvailable:CNContactEmailAddressesKey])
        {
            // 电子邮件
            NSMutableArray *emails = [NSMutableArray array];
            for (CNLabeledValue *labeledValue in contact.emailAddresses)
            {
                TFY_Email *emailModel = [[TFY_Email alloc] initWithLabeledValue:labeledValue];
                [emails addObject:emailModel];
            }
            self.emails = emails;
        }
        
        if ([contact isKeyAvailable:CNContactPostalAddressesKey])
        {
            // 地址
            NSMutableArray *addresses = [NSMutableArray array];
            for (CNLabeledValue *labeledValue in contact.postalAddresses)
            {
                TFY_Address *addressModel = [[TFY_Address alloc] initWithLabeledValue:labeledValue];
                [addresses addObject:addressModel];
            }
            self.addresses = addresses;
        }
        
        // 生日
        TFY_Birthday *birthday = [[TFY_Birthday alloc] initWithCNContact:contact];
        self.birthday = birthday;
        
        if ([contact isKeyAvailable:CNContactInstantMessageAddressesKey])
        {
            // 即时通讯
            NSMutableArray *messages = [NSMutableArray array];
            for (CNLabeledValue *labeledValue in contact.instantMessageAddresses)
            {
                TFY_Message *messageModel = [[TFY_Message alloc] initWithLabeledValue:labeledValue];
                [messages addObject:messageModel];
            }
            self.messages = messages;
        }
        
        if ([contact isKeyAvailable:CNContactSocialProfilesKey])
        {
            // 社交
            NSMutableArray *socials = [NSMutableArray array];
            for (CNLabeledValue *labeledValue in contact.socialProfiles)
            {
                TFY_SocialProfile *socialModel = [[TFY_SocialProfile alloc] initWithLabeledValue:labeledValue];
                [socials addObject:socialModel];
            }
            self.socials = socials;
        }
        
        if ([contact isKeyAvailable:CNContactRelationsKey])
        {
            // 关联人
            NSMutableArray *relations = [NSMutableArray array];
            for (CNLabeledValue *labeledValue in contact.contactRelations)
            {
                TFY_ContactRelation *relationModel = [[TFY_ContactRelation alloc] initWithLabeledValue:labeledValue];
                [relations addObject:relationModel];
            }
            self.relations = relations;
        }
        
        if ([contact isKeyAvailable:CNContactUrlAddressesKey])
        {
            // URL
            NSMutableArray *urlAddresses = [NSMutableArray array];
            for (CNLabeledValue *labeledValue in contact.urlAddresses)
            {
                TFY_UrlAddress *urlModel = [[TFY_UrlAddress alloc] initWithLabeledValue:labeledValue];
                [urlAddresses addObject:urlModel];
            }
            self.urls = urlAddresses;
        }
    }
    return self;
}

@end

@implementation TFY_Phone

- (instancetype)initWithLabeledValue:(CNLabeledValue *)labeledValue
{
    self = [super init];
    if (self)
    {
        CNPhoneNumber *phoneValue = labeledValue.value;
        NSString *phoneNumber = phoneValue.stringValue;
        self.phone = [NSString tfy_filterSpecialString:phoneNumber];
        self.label = [CNLabeledValue localizedStringForLabel:labeledValue.label];
    }
    return self;
}

@end

@implementation TFY_Email

- (instancetype)initWithLabeledValue:(CNLabeledValue *)labeledValue
{
    self = [super init];
    if (self)
    {
        self.label = [CNLabeledValue localizedStringForLabel:labeledValue.label];
        self.email = labeledValue.value;
    }
    return self;
}

@end

@implementation TFY_Address

- (instancetype)initWithLabeledValue:(CNLabeledValue *)labeledValue
{
    self = [super init];
    if (self)
    {
        CNPostalAddress *addressValue = labeledValue.value;
        self.label = [CNLabeledValue localizedStringForLabel:labeledValue.label];
        self.street = addressValue.street;
        self.state = addressValue.state;
        self.city = addressValue.city;
        self.postalCode = addressValue.postalCode;
        self.country = addressValue.country;
        self.ISOCountryCode = addressValue.ISOCountryCode;
        
        self.formatterAddress = [CNPostalAddressFormatter stringFromPostalAddress:addressValue style:CNPostalAddressFormatterStyleMailingAddress];
    }
    return self;
}

@end

@implementation TFY_Birthday

- (instancetype)initWithCNContact:(CNContact *)contact
{
    self = [super init];
    if (self)
    {
        if ([contact isKeyAvailable:CNContactBirthdayKey])
        {
            self.brithdayDate = contact.birthday.date;
        }
        
        if ([contact isKeyAvailable:CNContactNonGregorianBirthdayKey])
        {
            self.calendarIdentifier = contact.nonGregorianBirthday.calendar.calendarIdentifier;
            self.era = contact.nonGregorianBirthday.era;
            self.day = contact.nonGregorianBirthday.day;
            self.month = contact.nonGregorianBirthday.month;
            self.year = contact.nonGregorianBirthday.year;
        }
    }
    return self;
}

@end

@implementation TFY_Message

- (instancetype)initWithLabeledValue:(CNLabeledValue *)labeledValue
{
    self = [super init];
    if (self)
    {
        CNInstantMessageAddress *messageValue = labeledValue.value;
        self.service = messageValue.service;
        self.userName = messageValue.username;
    }
    return self;
}

@end

@implementation TFY_SocialProfile

- (instancetype)initWithLabeledValue:(CNLabeledValue *)labeledValue
{
    self = [super init];
    if (self)
    {
        CNSocialProfile *socialValue = labeledValue.value;
        self.service = socialValue.service;
        self.username = socialValue.username;
        self.urlString = socialValue.urlString;
    }
    return self;
}

@end

@implementation TFY_UrlAddress

- (instancetype)initWithLabeledValue:(CNLabeledValue *)labeledValue
{
    self = [super init];
    if (self)
    {
        self.label = [CNLabeledValue localizedStringForLabel:labeledValue.label];
        self.urlString = labeledValue.value;
    }
    return self;
}

@end

@implementation TFY_ContactRelation

- (instancetype)initWithLabeledValue:(CNLabeledValue *)labeledValue
{
    self = [super init];
    if (self)
    {
        CNContactRelation *relationValue = labeledValue.value;
        self.label = [CNLabeledValue localizedStringForLabel:labeledValue.label];;
        self.name = relationValue.name;
    }
    return self;
}


@end

@implementation TFY_SectionPerson


@end
