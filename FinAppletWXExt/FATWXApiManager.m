//
//  FATWXApiManager.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/20.
//

#import "FATWXApiManager.h"

static FATWXApiManager *instance = nil;

@implementation FATWXApiManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass: [WXLaunchMiniProgramResp class]]) {
        WXLaunchMiniProgramResp *loginResp = (WXLaunchMiniProgramResp*)resp;
        if (self.wxResponse) {
            self.wxResponse(loginResp);
        }
        return;
    } else {
        NSLog(@"不支持的类型返回");
    }
}

@end
