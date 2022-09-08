//
//  FATWXExtBaseApi.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/18.
//

#import "FATWXExtBaseApi.h"
#import <objc/runtime.h>

@implementation FATWXExtBaseApi

+ (FATWXExtBaseApi *)apiWithCommand:(NSString *)command param:(NSDictionary *)param {
    NSString *apiMethod = [NSString stringWithFormat:@"FATExt_%@", command];
    Class ApiClass = NSClassFromString(apiMethod);
    if (!ApiClass) {
        return nil;
    }
    FATWXExtBaseApi *api = [[ApiClass alloc] init];
    [api setValue:param forKey:@"param"];
    NSDictionary *propertyMap = @{};
    NSArray *mapToKeys = propertyMap.allValues;
    for (NSString *datakey in param.allKeys) {
        @autoreleasepool {
            NSString *propertyKey = datakey;
            objc_property_t property = class_getProperty([api class], [propertyKey UTF8String]);
            if (property) {
                id value = [param objectForKey:datakey];
                id safetyValue = [self parseFromKeyValue:value];
                if (!safetyValue) continue;
                NSString *propertyType = [NSString stringWithUTF8String:property_copyAttributeValue(property, "T")];
                propertyType = [propertyType stringByReplacingOccurrencesOfString:@"@" withString:@""];
                propertyType = [propertyType stringByReplacingOccurrencesOfString:@"\\" withString:@""];
                propertyType = [propertyType stringByReplacingOccurrencesOfString:@"\"" withString:@""];

                if (
                    [propertyType isEqualToString:@"NSString"] ||
                    [propertyType isEqualToString:@"NSArray"] ||
                    [propertyType isEqualToString:@"NSDictionary"]) {
                    if (![safetyValue isKindOfClass:NSClassFromString(propertyType)]) {
                        continue;
                    }
                }
                [api setValue:safetyValue forKey:propertyKey];
            }
        }
    }
    return api;
}

#pragma mark - moved from FATDataSecurityManager
// 作空值过滤处理-任意对象
+ (id)parseFromKeyValue:(id)value {
    //值无效
    if ([value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if ([value isKindOfClass:[NSNumber class]]) { //统一处理为字符串
        value = [NSString stringWithFormat:@"%@", value];
    } else if ([value isKindOfClass:[NSArray class]]) { //数组
        value = [self parseFromArray:value];
    } else if ([value isKindOfClass:[NSDictionary class]]) { //字典
        value = [self parseFromDictionary:value];
    }
    return value;
}

// 作空值过滤处理-字典对象
+ (NSDictionary *)parseFromDictionary:(NSDictionary *)container {
    if ([container isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *result = [NSMutableDictionary new];
        for (id key in container.allKeys) {
            @autoreleasepool {
                id value = container[key];
                id safetyValue = [self parseFromKeyValue:value];
                if (!safetyValue) {
                    safetyValue = @"";
                }
                [result setObject:safetyValue forKey:key];
            }
        }
        return result;
    }
    return container;
}

// 作空值过滤处理-数组对象
+ (NSArray *)parseFromArray:(NSArray *)container {
    if ([container isKindOfClass:[NSArray class]]) {
        NSMutableArray *result = [NSMutableArray new];
        for (int i = 0; i < container.count; i++) {
            @autoreleasepool {
                id value = container[i];
                id safetyValue = [self parseFromKeyValue:value];
                if (!safetyValue) {
                    safetyValue = @"";
                }
                [result addObject:safetyValue];
            }
        }
        return result;
    }
    return container;
}

- (void)setupApiWithCallback:(FATExtensionApiCallback)callback {
    NSLog(@"子类重写");
}


@end
