//
//  UIImage+TFY_UserAvatar.m
//  TFY_CHESHI
//
//  Created by 田风有 on 2019/3/29.
//  Copyright © 2019 田风有. All rights reserved.
//

#import "UIImage+TFY_UserAvatar.h"

@implementation TFY_UserAvatarOptional

- (instancetype)init {
    
    if(self == [super init]) {
        
        _tfy_avatarSize = CGSizeMake(60, 60);
        _tfy_avatarRadius = _tfy_avatarSize.width/2;
        _tfy_avatarBackgroundColor = [self tfy_colorWithHexString:@"17c295" alpha:1.0f];
        _tfy_hashBackgroundColorAry = @[
                                    [self tfy_colorWithHexString:@"17c295" alpha:1.0f],
                                    [self tfy_colorWithHexString:@"b38979" alpha:1.0f],
                                    [self tfy_colorWithHexString:@"f2725e" alpha:1.0f],
                                    [self tfy_colorWithHexString:@"f7b55e" alpha:1.0f],
                                    [self tfy_colorWithHexString:@"4da9eb" alpha:1.0f],
                                    [self tfy_colorWithHexString:@"5f70a7" alpha:1.0f],
                                    [self tfy_colorWithHexString:@"568aad" alpha:1.0f]];
        _tfy_adoptHash = YES;
        _tfy_avatarTitleColor = [UIColor whiteColor];
        _tfy_avatarTitleFont = [UIFont systemFontOfSize:15];
        _tfy_filterSpecial = YES;
        _tfy_avatarImageType = TFY_AvatarImageTypeShowAll;
    }
    return self;
}

- (UIColor *)tfy_colorWithHexString:(NSString *)hexColor alpha:(CGFloat)alpha {
    
    unsigned int red,green,blue;
    NSRange range;
    
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    UIColor *retColor = [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:alpha];
    return retColor;
}

@end

@implementation UIImage (TFY_UserAvatar)

+ (UIImage *)tfy_generateAvatarImageWithCharacter:(NSString *)character optional:(TFY_UserAvatarOptional * _Nullable)optional {
    
    if(optional == nil || !optional) {optional = [[TFY_UserAvatarOptional alloc]init];}
    
    character = [self tfy_characterInterception:character optional:optional];
    
    UIImage *image = nil;
    if(optional.tfy_adoptHash == YES) {
        
        image = [UIImage tfy_imageWithColor:optional.tfy_hashBackgroundColorAry[ABS(character.hash % optional.tfy_hashBackgroundColorAry.count)] size:optional.tfy_avatarSize cornerRadius:optional.tfy_avatarRadius];
        
    }else {
        
        image = [UIImage tfy_imageWithColor:optional.tfy_avatarBackgroundColor size:optional.tfy_avatarSize cornerRadius:optional.tfy_avatarRadius];
    }
    
    UIGraphicsBeginImageContextWithOptions (optional.tfy_avatarSize, NO , 0.0 );
    
    [image drawAtPoint: CGPointMake(0 , 0)];
    
    // 获得一个位图图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawPath (context, kCGPathStroke);
    
    // 画名字
    CGSize nameSize = [character sizeWithAttributes:@{NSFontAttributeName : optional.tfy_avatarTitleFont}];
    [character drawAtPoint :CGPointMake ((optional.tfy_avatarSize.width  - nameSize.width) / 2 , (optional.tfy_avatarSize.height  - nameSize.height) / 2) withAttributes : @{NSFontAttributeName :optional.tfy_avatarTitleFont, NSForegroundColorAttributeName :optional.tfy_avatarTitleColor}];
    
    // 返回绘制的新图形
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return newImage;
}

///按规则截取要生成的字符
+ (NSString *)tfy_characterInterception:(NSString *)character optional:(TFY_UserAvatarOptional *)optional {
    
    NSString *showName = @"";
    NSString *tempName = character;
    
    if(optional.tfy_filterSpecial == YES) {
        
        ///筛除部分特殊符号
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"[ _`~!@#$%^&*()+-=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]|\n|\r|\t"];
        tempName = [tempName stringByTrimmingCharactersInSet:set];
    }
    
    if(tempName.length > 0) {
        
        switch (optional.tfy_avatarImageType) {
                
            case TFY_AvatarImageTypeFirstCharacter:
                showName = [tempName substringToIndex:1];
                break;
                
            case TFY_AvatarImageTypeLastCharacter:
                showName = [tempName substringFromIndex:tempName.length-1];
                break;
                
            default:
                showName = tempName;
                break;
        }
    }
    
    return showName;
}

+ (UIImage *)tfy_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius {
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = CGSizeMake(1, 1);
    }
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(rect);
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    [colorImage drawInRect:rect];
    
    colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}

@end
