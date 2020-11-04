#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSString+TFY_Extension.h"
#import "TFY_ContactManager.h"
#import "TFY_ContactManagerKit.h"
#import "TFY_PeoplePickerDelegate.h"
#import "TFY_PersonModel.h"
#import "TFY_PickerDetailDelegate.h"

FOUNDATION_EXPORT double TFY_ContactManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char TFY_ContactManagerVersionString[];

