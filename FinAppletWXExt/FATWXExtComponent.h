//
//  FATWXExtComponent.h
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/18.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface FATWXExtComponent : NSObject

+ (BOOL)registerComponent:(NSString *)appld universalLink:(NSString *)universalLink;

@end

NS_ASSUME_NONNULL_END
