//
//  NSArray+TFY_Arr.m
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/20.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "NSArray+TFY_Arr.h"
#import "NSData+TFY_Data.h"

@implementation NSArray (TFY_Arr)
+ (NSArray *)tfy_arrayWithPlistData:(NSData *)plist {
    if (!plist) return nil;
    NSArray *array = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:NULL error:NULL];
    if ([array isKindOfClass:[NSArray class]]) return array;
    return nil;
}

+ (NSArray *)tfy_arrayWithPlistString:(NSString *)plist {
    if (!plist) return nil;
    NSData *data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self tfy_arrayWithPlistData:data];
}

- (NSData *)tfy_plistData {
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:NULL];
}

- (NSString *)tfy_plistString {
    NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:NULL];
    if (xmlData) return xmlData.tfy_utf8String;
    return nil;
}

- (id)tfy_randomObject {
    if (self.count) {
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}

- (id)tfy_objectOrNilAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
}

- (NSString *)tfy_jsonStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}

- (NSString *)tfy_jsonPrettyStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}
- (NSString *)tfy_descriptionWithLocale:(id)locale {
    NSMutableString * string = [NSMutableString string];
    [string appendString:@"[\n"];
    NSUInteger count = self.count;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * temp = nil;
        if ([obj respondsToSelector:@selector(descriptionWithLocale:)]) {
            temp = [obj performSelector:@selector(descriptionWithLocale:) withObject:locale];
            temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
        } else {
            temp = [obj performSelector:@selector(description) withObject:nil];
            if ([obj isKindOfClass:[NSString class]]) {
                temp = [NSString stringWithFormat:@"\"%@\"", temp];
            }
        }
        [string appendFormat:@"\t%@", temp];
        if (idx+1 != count) {
            [string appendString:@","];
        }
        [string appendString:@"\n"];
    }];
    [string appendString:@"]"];
    return string;
}
@end
