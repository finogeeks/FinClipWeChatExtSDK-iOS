//
//  FATWXUtils.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/22.
//

#import "FATWXUtils.h"

@implementation FATWXUtils

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (BOOL)fat_isEmptyWithString:(NSString *)string {
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }

    if (string.length == 0) {
        return YES;
    }

    return NO;
}

+ (BOOL)fat_isEmptyArrayWithArry:(NSArray *)array {
    if (!array || ![array isKindOfClass:[NSArray class]]) {
        return YES;
    }

    if (array.count == 0) {
        return YES;
    }

    return NO;
}

@end
