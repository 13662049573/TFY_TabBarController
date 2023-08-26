//
//  UIViewController+RootNavigation.m
//  RootNavigation
//
//  Created by 田风有 on 2021/8/8.
//  Copyright © 2021 浙江日报集团. All rights reserved.
//

#import "UIViewController+RootNavigation.h"
#import "TFY_NavigationController.h"
#import <objc/runtime.h>

CG_INLINE BOOL Nav_iPhoneX() {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ((NSInteger)(([[UIScreen mainScreen] currentMode].size.height/[[UIScreen mainScreen] currentMode].size.width)*100) == 216) : NO);
}
/**导航栏高度*/
CG_INLINE CGFloat Nav_kNavBarHeight() {
    return (Nav_iPhoneX() ? 88.0 : 64.0);
}

@interface UIColor (navHex)
+ (UIColor *)colorWithHexString:(NSString *)color;
//从十六进制字符串获取颜色，
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end

@implementation UIViewController (RootNavigation)
@dynamic tfy_disableInteractivePop;

- (void)setTfy_disableInteractivePop:(BOOL)tfy_disableInteractivePop
{
    objc_setAssociatedObject(self, @selector(tfy_disableInteractivePop), @(tfy_disableInteractivePop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.tfy_navigationController.tfy_topViewController == self) {
        self.tfy_navigationController.interactivePopGestureRecognizer.enabled = !tfy_disableInteractivePop;
    }
}

- (BOOL)tfy_disableInteractivePop
{
    return [objc_getAssociatedObject(self, @selector(tfy_disableInteractivePop)) boolValue];
}

- (Class)tfy_navigationBarClass
{
    return nil;
}

- (TFY_NavigationController *)tfy_navigationController
{
    UIViewController *vc = self;
    while (vc && ![vc isKindOfClass:[TFY_NavigationController class]]) {
        vc = vc.navigationController;
    }
    return (TFY_NavigationController *)vc;
}

- (void)setTfy_isHiddenNavBar:(BOOL)tfy_isHiddenNavBar {
    NSNumber *number = [NSNumber numberWithBool:tfy_isHiddenNavBar];
    objc_setAssociatedObject(self, @selector(tfy_isHiddenNavBar), number, OBJC_ASSOCIATION_ASSIGN);
    [self hiddenNavigationBar];
}

- (BOOL)tfy_isHiddenNavBar {
    NSNumber *number = objc_getAssociatedObject(self, @selector(tfy_isHiddenNavBar));
    return number.boolValue;
}

- (void)hiddenNavigationBar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
    forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)setTfy_alphaFloat:(CGFloat)tfy_alphaFloat {
    NSNumber *number = [NSNumber numberWithBool:tfy_alphaFloat];
    objc_setAssociatedObject(self, @selector(tfy_alphaFloat), number, OBJC_ASSOCIATION_ASSIGN);
    [self contentOffset:tfy_alphaFloat];
}

- (CGFloat)tfy_alphaFloat {
    NSNumber *number = objc_getAssociatedObject(self, @selector(tfy_alphaFloat));
    return number.floatValue;
}

- (void)contentOffset:(CGFloat)offectY {
    CGFloat alphaIndex = (CGFloat)(offectY/Nav_kNavBarHeight());
    NSString *colorStr = self.tfy_alphaColor.length > 0?self.tfy_alphaColor:@"ffffff";
    [self.navigationController.navigationBar setBackgroundImage:[self tfy_imageWithColor:[UIColor colorWithHexString:colorStr alpha:alphaIndex]]
    forBarMetrics:UIBarMetricsDefault];
}

- (void)setTfy_navBackgroundColor:(UIColor *)tfy_navBackgroundColor {
    objc_setAssociatedObject(self, @selector(tfy_navBackgroundColor), tfy_navBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.view.backgroundColor = tfy_navBackgroundColor;
}

- (UIColor *)tfy_navBackgroundColor {
    return objc_getAssociatedObject(self, @selector(tfy_navBackgroundColor));
}

- (void)setTfy_alphaColor:(NSString *)tfy_alphaColor {
    objc_setAssociatedObject(self, @selector(tfy_alphaColor), tfy_alphaColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)tfy_alphaColor {
    return objc_getAssociatedObject(self, @selector(tfy_alphaColor));
}

- (id<UIViewControllerAnimatedTransitioning>)tfy_animatedTransitioning
{
    return nil;
}

-(UIImage *)tfy_imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

@implementation UIColor (navHex)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

@end
