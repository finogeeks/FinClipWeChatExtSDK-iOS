//
//  FATWXUtils.h
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FATWXUtils : NSObject

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (BOOL)fat_isEmptyWithString:(NSString *)string;

+ (BOOL)fat_isEmptyArrayWithArry:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
