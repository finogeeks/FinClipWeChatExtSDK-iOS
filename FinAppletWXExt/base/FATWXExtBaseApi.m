//
//  FATWXExtBaseApi.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/18.
//

#import "FATWXExtBaseApi.h"
#import <objc/runtime.h>

@implementation FATWXExtBaseApi

- (void)setupApiWithSuccess:(void (^)(NSDictionary<NSString *, id> *successResult))success
                    failure:(void (^)(NSDictionary *failResult))failure
                     cancel:(void (^)(NSDictionary *cancelResult))cancel {
    //默认实现，子类重写！！！
    if (cancel) {
        cancel(@{});
    }

    if (success) {
        success(@{});
    }

    if (failure) {
        failure(nil);
    }
}

/**
 同步api，子类重写
 */
- (NSString *)setupSyncApi {
    return nil;
}

@end
